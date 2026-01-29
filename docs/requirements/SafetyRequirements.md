# Robots requirements

## Safety requirements
```mermaid
%%{ init : { 'theme' : 'default' } }%%
requirementDiagram

designConstraint SR_Fire_Hazard_1 {
    id: 1
    text: The robots shall not catch fire under long exposure to sun under Latitude higher than 30 degrees
    risk: high
    verifymethod: analysis
}

designConstraint SR_Fire_Hazard_2 {
    id: 2
    text: The robots shall not catch fire at temperature lower than 60 degrees
    risk: high
    verifymethod: analysis
}

designConstraint SR_Fire_Hazard_3 {
    id: 2
    text: The robots shall not catch fire when stored for extensive duration (5 years or less.)
    risk: high
    verifymethod: analysis
}

designConstraint SR_Fire_Hazard_4 {
    id: 2
    text: The robots shall not catch fire when operated continuously at maximum rated power at temperature lower than 60 degrees.
    risk: high
    verifymethod: analysis
}

designConstraint SR_Fire_Hazard_SafetyGoal {
    id: 3
    text: The robots shall not catching fire
    risk: high
    verifymethod: analysis
}

element battery_datasheet {
    type: doc
}

battery_datasheet - satisfies -> SR_Fire_Hazard_2
SR_Fire_Hazard_2 - derives -> SR_Fire_Hazard_SafetyGoal
SR_Fire_Hazard_1 - derives -> SR_Fire_Hazard_SafetyGoal
SR_Fire_Hazard_3 - derives -> SR_Fire_Hazard_SafetyGoal
SR_Fire_Hazard_4 - derives -> SR_Fire_Hazard_SafetyGoal
```
