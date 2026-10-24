package SafetyRequirements {
    private import StandardViewDefinitions::*;

    requirement def SafetyRequirement {
        attribute id : ScalarValues::String;
        attribute statement : ScalarValues::String;
        attribute risk : ScalarValues::String;
        attribute verificationMethod : ScalarValues::String;
    }

    requirement def SafetyGoal :> SafetyRequirement;
    requirement def TechnicalSafetyRequirement :> SafetyRequirement;

    requirement SG_TopSafetyGoal : SafetyGoal {
        attribute :>> id = "0ac871a4";
        attribute :>> statement = "The robots shall operate safely under all circumstances";
        attribute :>> risk = "high";
        attribute :>> verificationMethod = "analysis";
    }

    requirement SG_NoCatchingFire : SafetyGoal {
        attribute :>> id = "74515f7f";
        attribute :>> statement = "The robots shall not catching fire";
        attribute :>> risk = "high";
        attribute :>> verificationMethod = "analysis";
    }

    requirement SG_NoHighKineticEnergyImpact : SafetyGoal {
        attribute :>> id = "a36c5bfb";
        attribute :>> statement = "The robots shall impact surroundings or human with harzardeous kinetic energny";
        attribute :>> risk = "high";
        attribute :>> verificationMethod = "analysis";
    }

    requirement TSR_NoFireUnderSun : TechnicalSafetyRequirement {
        attribute :>> id = "69e005b9";
        attribute :>> statement = "The robots shall not catch fire under long exposure to sun under Latitude higher than 30 degrees";
        attribute :>> risk = "high";
        attribute :>> verificationMethod = "analysis";
    }

    requirement TSR_NoFireHighTemperature : TechnicalSafetyRequirement {
        attribute :>> id = "1975ef0f";
        attribute :>> statement = "The robots shall not catch fire at temperature lower than 60 degrees";
        attribute :>> risk = "high";
        attribute :>> verificationMethod = "analysis";
    }

    requirement TSR_NoFireLongStorage : TechnicalSafetyRequirement {
        attribute :>> id = "1975ef0f";
        attribute :>> statement = "The robots shall not catch fire when stored for extensive duration (5 years or less.)";
        attribute :>> risk = "high";
        attribute :>> verificationMethod = "analysis";
    }

    requirement TSR_IntenseOpeerations : TechnicalSafetyRequirement {
        attribute :>> id = "57df1b42";
        attribute :>> statement = "The robots shall not catch fire when operated continuously at maximum rated power at temperature lower than 60 degrees.";
        attribute :>> risk = "high";
        attribute :>> verificationMethod = "analysis";
    }

    part def SafetyEvidence;
    part battery_datasheet : SafetyEvidence;

    dependency SG_NoCatchingFire_derives_SG_TopSafetyGoal
        from SG_NoCatchingFire to SG_TopSafetyGoal;
    dependency SG_NoHighKineticEnergyImpact_derives_SG_TopSafetyGoal
        from SG_NoHighKineticEnergyImpact to SG_TopSafetyGoal;
    dependency TSR_NoFireUnderSun_derives_SG_NoCatchingFire
        from TSR_NoFireUnderSun to SG_NoCatchingFire;
    dependency TSR_NoFireHighTemperature_derives_SG_NoCatchingFire
        from TSR_NoFireHighTemperature to SG_NoCatchingFire;
    dependency TSR_NoFireLongStorage_derives_SG_NoCatchingFire
        from TSR_NoFireLongStorage to SG_NoCatchingFire;
    dependency TSR_IntenseOpeerations_derives_SG_NoCatchingFire
        from TSR_IntenseOpeerations to SG_NoCatchingFire;
    dependency battery_datasheet_satisfies_TSR_NoFireHighTemperature
        from battery_datasheet to TSR_NoFireHighTemperature;

    view def SafetyRequirementsView specializes GeneralView {
    }

    view SafetyRequirementsDiagram : SafetyRequirementsView {
        expose SG_TopSafetyGoal;
        expose SG_NoCatchingFire;
        expose SG_NoHighKineticEnergyImpact;
        expose TSR_NoFireUnderSun;
        expose TSR_NoFireHighTemperature;
        expose TSR_NoFireLongStorage;
        expose TSR_IntenseOpeerations;
        expose battery_datasheet;
        expose SG_NoCatchingFire_derives_SG_TopSafetyGoal;
        expose SG_NoHighKineticEnergyImpact_derives_SG_TopSafetyGoal;
        expose TSR_NoFireUnderSun_derives_SG_NoCatchingFire;
        expose TSR_NoFireHighTemperature_derives_SG_NoCatchingFire;
        expose TSR_NoFireLongStorage_derives_SG_NoCatchingFire;
        expose TSR_IntenseOpeerations_derives_SG_NoCatchingFire;
        expose battery_datasheet_satisfies_TSR_NoFireHighTemperature;
        render asTreeDiagram;
    }
}
