PROGRAM main
VAR
    (* ---- Tier 1a: unauthenticated read (holding registers 0-2) ---- *)
    BloodLevel     AT %QW0 : UINT;
    WineLevel      AT %QW1 : UINT;
    Tank_Pressure  AT %QW2 : UINT;

    (* ---- Tier 1b: unauthenticated write ---- *)
    (* Modbus coil 0: maintenance override. Default FALSE. *)
    Maint_Override AT %QX0.0 : BOOL;
    (* Coil 1: mirrors override state, visible to players *)
    Override_Active AT %QX0.1 : BOOL;

    (* Flag as one ASCII char per holding register, addresses 10-29 *)
    Flag_00 AT %QW10 : UINT;
    Flag_01 AT %QW11 : UINT;
    Flag_02 AT %QW12 : UINT;
    Flag_03 AT %QW13 : UINT;
    Flag_04 AT %QW14 : UINT;
    Flag_05 AT %QW15 : UINT;
    Flag_06 AT %QW16 : UINT;
    Flag_07 AT %QW17 : UINT;
    Flag_08 AT %QW18 : UINT;
    Flag_09 AT %QW19 : UINT;
    Flag_10 AT %QW20 : UINT;
    Flag_11 AT %QW21 : UINT;
    Flag_12 AT %QW22 : UINT;
    Flag_13 AT %QW23 : UINT;
    Flag_14 AT %QW24 : UINT;
    Flag_15 AT %QW25 : UINT;
    Flag_16 AT %QW26 : UINT;
    Flag_17 AT %QW27 : UINT;
    Flag_18 AT %QW28 : UINT;
    Flag_19 AT %QW29 : UINT;

    (* ---- Tier 1c: recon/fingerprinting (holding registers 30-60, always readable) ---- *)
    Flag1c_00 AT %QW30 : UINT;
    Flag1c_01 AT %QW31 : UINT;
    Flag1c_02 AT %QW32 : UINT;
    Flag1c_03 AT %QW33 : UINT;
    Flag1c_04 AT %QW34 : UINT;
    Flag1c_05 AT %QW35 : UINT;
    Flag1c_06 AT %QW36 : UINT;
    Flag1c_07 AT %QW37 : UINT;
    Flag1c_08 AT %QW38 : UINT;
    Flag1c_09 AT %QW39 : UINT;
    Flag1c_10 AT %QW40 : UINT;
    Flag1c_11 AT %QW41 : UINT;
    Flag1c_12 AT %QW42 : UINT;
    Flag1c_13 AT %QW43 : UINT;
    Flag1c_14 AT %QW44 : UINT;
    Flag1c_15 AT %QW45 : UINT;
    Flag1c_16 AT %QW46 : UINT;
    Flag1c_17 AT %QW47 : UINT;
    Flag1c_18 AT %QW48 : UINT;
    Flag1c_19 AT %QW49 : UINT;
    Flag1c_20 AT %QW50 : UINT;
    Flag1c_21 AT %QW51 : UINT;
    Flag1c_22 AT %QW52 : UINT;
    Flag1c_23 AT %QW53 : UINT;
    Flag1c_24 AT %QW54 : UINT;
    Flag1c_25 AT %QW55 : UINT;
    Flag1c_26 AT %QW56 : UINT;
    Flag1c_27 AT %QW57 : UINT;
    Flag1c_28 AT %QW58 : UINT;
    Flag1c_29 AT %QW59 : UINT;
    Flag1c_30 AT %QW60 : UINT;
END_VAR

VAR
    (* Auto-reset so one team cannot leave the challenge in a spoiled state *)
    Reset_Timer : TON;
END_VAR

(* Tier 1a: reassigned every scan so any tampering is overwritten *)
BloodLevel := 12345;
WineLevel := 75;
Tank_Pressure := 2500;

(* Tier 1c: always-on flag, one ASCII char per register *)
Flag1c_00 := 114;  (* 'r' *)
Flag1c_01 := 111;  (* 'o' *)
Flag1c_02 := 119;  (* 'w' *)
Flag1c_03 := 100;  (* 'd' *)
Flag1c_04 := 121;  (* 'y' *)
Flag1c_05 := 123;  (* '{' *)
Flag1c_06 := 66;  (* 'B' *)
Flag1c_07 := 48;  (* '0' *)
Flag1c_08 := 114;  (* 'r' *)
Flag1c_09 := 114;  (* 'r' *)
Flag1c_10 := 48;  (* '0' *)
Flag1c_11 := 119;  (* 'w' *)
Flag1c_12 := 95;  (* '_' *)
Flag1c_13 := 84;  (* 'T' *)
Flag1c_14 := 104;  (* 'h' *)
Flag1c_15 := 51;  (* '3' *)
Flag1c_16 := 115;  (* 's' *)
Flag1c_17 := 101;  (* 'e' *)
Flag1c_18 := 95;  (* '_' *)
Flag1c_19 := 80;  (* 'P' *)
Flag1c_20 := 48;  (* '0' *)
Flag1c_21 := 114;  (* 'r' *)
Flag1c_22 := 116;  (* 't' *)
Flag1c_23 := 115;  (* 's' *)
Flag1c_24 := 95;  (* '_' *)
Flag1c_25 := 84;  (* 'T' *)
Flag1c_26 := 104;  (* 'h' *)
Flag1c_27 := 49;  (* '1' *)
Flag1c_28 := 101;  (* 'e' *)
Flag1c_29 := 102;  (* 'f' *)
Flag1c_30 := 125;  (* '}' *)

Override_Active := Maint_Override;

(* Auto-reset *)
Reset_Timer(IN := Maint_Override, PT := T#45s);
IF Reset_Timer.Q THEN
    Maint_Override := FALSE;
END_IF;

IF Maint_Override THEN
    Flag_00 := 114;  (* 'r' *)
    Flag_01 := 111;  (* 'o' *)
    Flag_02 := 119;  (* 'w' *)
    Flag_03 := 100;  (* 'd' *)
    Flag_04 := 121;  (* 'y' *)
    Flag_05 := 123;  (* '{' *)
    Flag_06 := 78;  (* 'N' *)
    Flag_07 := 49;  (* '1' *)
    Flag_08 := 71;  (* 'G' *)
    Flag_09 := 72;  (* 'H' *)
    Flag_10 := 84;  (* 'T' *)
    Flag_11 := 79;  (* 'O' *)
    Flag_12 := 70;  (* 'F' *)
    Flag_13 := 77;  (* 'M' *)
    Flag_14 := 79;  (* 'O' *)
    Flag_15 := 68;  (* 'D' *)
    Flag_16 := 66;  (* 'B' *)
    Flag_17 := 85;  (* 'U' *)
    Flag_18 := 83;  (* 'S' *)
    Flag_19 := 125;  (* '}' *)
ELSE
    Flag_00 := 0;
    Flag_01 := 0;
    Flag_02 := 0;
    Flag_03 := 0;
    Flag_04 := 0;
    Flag_05 := 0;
    Flag_06 := 0;
    Flag_07 := 0;
    Flag_08 := 0;
    Flag_09 := 0;
    Flag_10 := 0;
    Flag_11 := 0;
    Flag_12 := 0;
    Flag_13 := 0;
    Flag_14 := 0;
    Flag_15 := 0;
    Flag_16 := 0;
    Flag_17 := 0;
    Flag_18 := 0;
    Flag_19 := 0;
END_IF;

END_PROGRAM

CONFIGURATION Config0
    RESOURCE Res0 ON PLC
        TASK TaskMain(INTERVAL := T#50ms, PRIORITY := 0);
        PROGRAM InstMain WITH TaskMain : main;
    END_RESOURCE
END_CONFIGURATION
