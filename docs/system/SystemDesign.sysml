package SystemDesign {
    private import StandardViewDefinitions::*;

    part def Battery {
        attribute configuration : ScalarValues::String = "2S Li-ion";
        attribute voltageRange : ScalarValues::String = "7.4–8.4 V";
    }

    part def MotorPowerRail {
        attribute maximumVoltage : ScalarValues::String = "~9 V";
    }

    part def BuckConverter {
        attribute outputVoltage : ScalarValues::String = "5 V";
    }

    part def LdoBuck {
        attribute outputVoltage : ScalarValues::String = "3.3 V";
    }

    part def RaspberryPi {
        attribute model : ScalarValues::String = "Raspberry Pi 4/5";
        attribute operatingSystem : ScalarValues::String = "Linux";
        doc /* High-level logic, kinematics, networking/UI, and OTA firmware flashing. */
    }

    part def Stm32Mcu {
        doc /* Real-time control, closed-loop motor control, encoder feedback, and a safety watchdog that stops motors if communication is lost. */
    }

    part def CanBus {
        attribute interface : ScalarValues::String = "CAN (or UART for V1)";
    }

    part def MotorDrivers {
        attribute driverType : ScalarValues::String = "H-Bridge";
    }

    part def DriveMotors {
        attribute quantity : ScalarValues::String = "4";
        attribute motorType : ScalarValues::String = "DC with gearbox";
    }

    part def SteeringMotors {
        attribute quantity : ScalarValues::String = "4";
        attribute motorType : ScalarValues::String = "DC with gearbox";
    }

    part def Encoders {
        attribute quantity : ScalarValues::String = "8";
        attribute monitoredAxes : ScalarValues::String = "Drive and steering";
    }

    part def SwdHeader;
    part def Boot0Control;
    part def ResetControl;

    part def Drone {
        part battery : Battery;
        part motorPowerRail : MotorPowerRail;
        part buckConverter : BuckConverter;
        part ldoBuck : LdoBuck;

        part raspberryPi : RaspberryPi;
        part stm32 : Stm32Mcu;
        part canBus : CanBus;

        part motorDrivers : MotorDrivers;
        part driveMotors : DriveMotors;
        part steeringMotors : SteeringMotors;
        part encoders : Encoders;

        part swdHeader : SwdHeader;
        part boot0Control : Boot0Control;
        part resetControl : ResetControl;

        connection batteryToMotorPowerRail connect battery to motorPowerRail;
        connection batteryToBuckConverter connect battery to buckConverter;
        connection buckConverterToRaspberryPi connect buckConverter to raspberryPi;
        connection buckConverterToLdoBuck connect buckConverter to ldoBuck;
        connection ldoBuckToStm32 connect ldoBuck to stm32;

        connection raspberryPiToCanBus connect raspberryPi to canBus;
        connection canBusToStm32 connect canBus to stm32;

        connection stm32ToMotorDrivers connect stm32 to motorDrivers;
        connection motorPowerRailToMotorDrivers connect motorPowerRail to motorDrivers;
        connection motorDriversToDriveMotors connect motorDrivers to driveMotors;
        connection motorDriversToSteeringMotors connect motorDrivers to steeringMotors;
        connection driveMotorsToEncoders connect driveMotors to encoders;
        connection steeringMotorsToEncoders connect steeringMotors to encoders;
        connection encodersToStm32 connect encoders to stm32;

        connection raspberryPiToBoot0Control connect raspberryPi to boot0Control;
        connection raspberryPiToResetControl connect raspberryPi to resetControl;
        connection boot0ControlToStm32 connect boot0Control to stm32;
        connection resetControlToStm32 connect resetControl to stm32;
        connection swdHeaderToStm32 connect swdHeader to stm32;
    }

    view def SystemDesignView specializes GeneralView {
        filter @SysML::PartUsage or @SysML::PartDefinition or @SysML::ConnectionUsage;
    }

    view DroneSystemDiagram : InterconnectionView {
        expose Drone;
    }
}
