package HardwareInTheLoopRequirements {
    private import StandardViewDefinitions::*;

    requirement def HILRequirement {
        attribute id : ScalarValues::String;
        attribute statement : ScalarValues::String;
        attribute risk : ScalarValues::String;
        attribute verificationMethod : ScalarValues::String;
    }

    requirement def HILDesignConstraint :> HILRequirement;

    requirement HIL_is_Pi4B : HILRequirement {
        attribute :>> id = "4d1512a0";
        attribute :>> statement = "The HIL itself shall consist of a Raspberry Pi 4B running a raspion 64 bit OS.";
        attribute :>> risk = "low";
        attribute :>> verificationMethod = "Inspection";
    }

    requirement HIL_is_BluePill : HILRequirement {
        attribute :>> id = "0aafe994";
        attribute :>> statement = "The system under test shall be a STM32F103C8T6 on a blue pill board.";
        attribute :>> risk = "low";
        attribute :>> verificationMethod = "Inspection";
    }

    requirement HIL_Pi_communicate_to_Pill_over_UART : HILRequirement {
        attribute :>> id = "01d62788";
        attribute :>> statement = "The HIL and the system under test shall communicate over UART.";
        attribute :>> risk = "low";
        attribute :>> verificationMethod = "Inspection";
    }

    requirement HIL_flashes_firmware_over_STLINK : HILRequirement {
        attribute :>> id = "b5105c86";
        attribute :>> statement = "The HIL shall use a STLinkV2 to flash new firmware on the system under test.";
        attribute :>> risk = "low";
        attribute :>> verificationMethod = "Inspection";
    }

    requirement HIL_can_reboot_STM32 : HILRequirement {
        attribute :>> id = "b5105c86";
        attribute :>> statement = "The system under test shall be reset (rebooted) via a command line on the HIL.";
        attribute :>> risk = "low";
        attribute :>> verificationMethod = "Inspection";
    }

    requirement TSR_HIL_not_catching_fire : HILDesignConstraint {
        attribute :>> id = "2de47c93";
        attribute :>> statement = "The HIL shall not catch fire";
        attribute :>> risk = "low";
        attribute :>> verificationMethod = "Inspection";
    }

    requirement TSR_HIL_no_equipement_damage : HILDesignConstraint {
        attribute :>> id = "3edd0a63";
        attribute :>> statement = "The HIL shall not damage any electronic equipment under any circumstances";
        attribute :>> risk = "low";
        attribute :>> verificationMethod = "Inspection";
    }

    requirement HIL_common_grounds : HILRequirement {
        attribute :>> id = "cdcef65d";
        attribute :>> statement = "All electronic equipment shall use common ground.";
        attribute :>> risk = "low";
        attribute :>> verificationMethod = "Inspection";
    }

    dependency HIL_common_grounds_derives_fire from HIL_common_grounds to TSR_HIL_not_catching_fire;
    dependency HIL_common_grounds_derives_equipment_damage from HIL_common_grounds to TSR_HIL_no_equipement_damage;

    view def HILRequirementsView specializes GeneralView {
    }

    view HILRequirementsDiagram : HILRequirementsView {
        expose HIL_is_Pi4B;
        expose HIL_is_BluePill;
        expose HIL_Pi_communicate_to_Pill_over_UART;
        expose HIL_flashes_firmware_over_STLINK;
        expose HIL_can_reboot_STM32;
        expose TSR_HIL_not_catching_fire;
        expose TSR_HIL_no_equipement_damage;
        expose HIL_common_grounds;
        expose HIL_common_grounds_derives_fire;
        expose HIL_common_grounds_derives_equipment_damage;
        render asTreeDiagram;
    }
}
