"""Configuration data container with interactive ipywidgets GUI"""

import jsonschema
import ipywidgets
import json

class DictWidget():
    """Container class for configuration data

    Constructed from a JSON Schema. Use like a dictionary to store and retrieve configuration data.
    Will also create a ipywidget interactive representation via `gui()`. Also supports nested schemata
    (i.e. a schema tha contains `object` properties, which are themselves configuration containers."""

    def __init__(self, schema):
        """Construct a Configuration object from a JSON schema definition"""

        self.schema = schema
        self.data = {}
        self.callback = None
        self.children = {}

        # Create GUI
        # Widget objects are collected in a dictionary (for update in __setitem__())
        # as well as a list (together with their description labels to create a VBox for display).
        self.widgets = {}
        self.widgetlist = []
        for name, props in self.schema['properties'].items():
            minimum = props.get('minimum', None)
            maximum = props.get('maximum', None)
            description = props.get('description', '')
            # Containers create new `Configuration` instances - save those children for later
            if props['type'] == 'object':
                subschema = {"title": name, "type": "object", "properties": props['properties']}
                self.children[name] = Configuration(subschema)
            else:
                # Scalar data elements are displayed as is
                if props['type'] == 'integer':
                    value = self.data.get(name, props.get('default', 0))
                    widget = ipywidgets.IntSlider(description=name, min=minimum, max=maximum, value=value)
                elif props['type'] == 'number':
                    value = self.data.get(name, props.get('default', 0.0))
                    widget = ipywidgets.FloatSlider(description=name, min=minimum, max=maximum, value=value)
                elif props['type'] == 'string':
                    # also supports drop down
                    value = self.data.get(name, props.get('default', ''))
                    if 'choices' in props:
                        widget = ipywidgets.Dropdown(options=props['choices'].split(';'), value=value, description=name)
                    else:
                        widget = ipywidgets.Text(description=name, value=value)
                elif props['type'] == 'boolean':
                    value = self.data.get(name, props.get('default', False))
                    widget = ipywidgets.Checkbox(description=name, value=value)
                else:
                    widget = ipywidgets.Label(description=name, value=f"Don't know how to draw {props['type']}")

                widget.observe(self.on_value_change, names='value')
                # save for self-reference
                self.widgets[name] = widget 
                self.widgetlist.append(ipywidgets.HBox([widget, ipywidgets.Label(value=description)]))

        # Add all saved children in a Tab
        if self.children:
            widget = ipywidgets.Tab([c._gui for c in self.children.values()])
            for i, c in enumerate(self.children.keys()):
                widget.set_title(i, c)
            widget.observe(self.on_value_change, names='value')
            # save for self-reference
            self.widgets['_children'] = widget 
            self.widgetlist.append(widget)

        # Return all widgets in a VBox
        self._gui = ipywidgets.VBox(self.widgetlist)


    def from_dict(self, dict_in):
        """Load configuration data from a dictionary.

        Will validate input against schema used in object construction."""

        jsonschema.validate(dict_in, self.schema)
        for key, value in dict_in.items():
            if isinstance(value, dict):
                self.children[key].from_dict(value)
            else:
                self[key] = value


    def from_json(self, json_in):
        """Load configuration data from JSON."""

        temp = json.loads(json_in)
        self.from_dict(temp)


    def to_json(self):
        """Dump configuration data as JSON."""

        if not self.data:
            return None
        return json.dumps(self.to_dict())


    def to_dict(self):
        """Dump configuration data as dictionary."""

        ret = dict(self.data)
        for name, child in self.children.items():
            ret[name] = child.to_dict()
        return ret


    def __repr__(self):
        return 'Configuration "' + self.schema['title'] + '" ' + str(self.data)


    def __getitem__(self, item):
        """Allow using dict syntax for object retrievel.

        Will first try to locate a child configuration object. If that's not found,
        it will then look for a data item."""

        if item in self.children:
            return self.children[item]
        return self.data.__getitem__(item)


    def __setitem__(self, item, value):
        """Allow using dict syntax for setting values.

        Will only allow setting values in accordance with schema used for object
        generation."""

        if item not in self.schema['properties']:
            raise KeyError(f'"{item}" not in schema')
        temp = dict(self.data)
        temp.__setitem__(item, value)
        jsonschema.validate(temp, self.schema)
        self.data.__setitem__(item, value)
        # update any gui that may exist
        if item in self.widgets:
            self.widgets[item].value = value


    def on_value_change(self, change):
        """Callback for GUI updates."""

        key = change['owner'].description
        self[key] = change['new']
        if self.callback:
            self.callback(self.to_dict()) # TODO: expensive!

    def interact(self, callback=None):
        """Return an interactive ipywidgets GUI for setting configuration values.

        Will call `callback` with a dictionary of data values on change."""

        self.callback = callback
        # Update children's callbacks, too.
        for c in self.children.values():
            c.callback = callback
        return self._gui
