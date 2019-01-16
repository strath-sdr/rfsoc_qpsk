function re = CtrlFSM_FFT_MOD(AXIwrite, tlast, dcount, AXIauto, sof)
  
    IDLE = 0;
    OUTPUT = 1;
    WAIT = 2;

    %state = 0;
    persistent state, 
    state = xl_state(IDLE, {xlUnsigned, 2, 0});

    switch state
        
        case IDLE
            if AXIwrite == 1 && dcount == 1 && tlast == 0 && sof == 1
                re = 1;
                state = OUTPUT;
            else
                re = 0;
            end
 
        case OUTPUT
            if tlast == 1
                re = 0;
                state = WAIT;
            else
                re = 1;
            end

        case WAIT
            if AXIwrite == 0 || AXIauto == 1
                re = 0;
                state = IDLE;
            else
                re = 0;
            end

        otherwise
            state = IDLE;
            re = 0;
    end
end