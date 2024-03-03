# CancerSSDTs
Data, codes, and supplementary information used to identify strictly-selective drug targets for 13 cancers.  

### Requirements
The following tools are needed:
1. [COBRA Toolbox](https://opencobra.github.io/cobratoolbox/stable/)
2. [rFASTCORMICS](https://github.com/sysbiolux/rFASTCORMICS)
2. CPLEX v12.9.0 or any CPLEX version compatible with MATLAB.

### SSDTs identification process overview:

![alt text](https://github.com/CSBLaboratory/CancerSSDTs/blob/main/Graphical_Abstract.tif)


### To get the strictly selective lethal sets follow the steps below:
##### Initialize COBRA toolbox:
```
initCobraToolbox
``` 

##### Use [rFASTCORMICS](https://github.com/sysbiolux/rFASTCORMICS) to build the normal and cancer context-specific models for each tissue. The parameters for this step are provided in BuildCSM.m. Provided models are available in [Contex_Specific_Models](https://github.com/CSBLaboratory/CancerSSDTs/tree/main/Context_Specific_Models):
```
BuildCSM.m
``` 

##### Use RapidSL to identify single and synthetic lethal drug targets for all cancers. A sample script is provided in RunRapidSL.m for this step. All identified selective and non-selective solutions are available in [All_Identified_Synthetic_Lethal_Non_Selective](https://github.com/CSBLaboratory/CancerSSDTs/tree/main/All_Identified_Synthetic_Lethal_Non_Selective):
```
RunRapidSL.m
```

##### Use FindSSDTs.m function to extract Strictly-Selective drug targets for each cancer. A sample use of this function is provided in IdentifySelectives.m:
``` 
IdentifySelectives.m;
```

##### All SSDTs identified in this study are available in the [Supplementary_File_S1](https://github.com/CSBLaboratory/CancerSSDTs/blob/main/Supplementry_Files/Supplementary_File_S1.xlsx):


### This webpage represents the data related to the following submitted manuscript:
> Manshadi et al.,"Higher order synthetic lethals are keys to minimize cancer treatment effects on normal cells".
