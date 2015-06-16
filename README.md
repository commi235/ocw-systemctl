# Generic systemctl Agent for Oracle Clusterware #
## What is this... ##
The systemctl_agent.sh provides a simple Action Script for Oracle Clusterware
to control services on operating systems using systemctl.
## Installation ##
All operations should be run as root user.  

1.  Place included file systemctl_agent.sh in a known location.  
2.  Add a new resource type to Clusterware  
    Change */path/to/systemctl_agent.sh* to match where you placed the action script  

    ```
    crsctl add type systemctl_agent_type \
      -basetype cluster_resource \
      -attr "ATTRIBUTE=SVC_NAME,TYPE=string,FLAGS=REQUIRED,
             ATTRIBUTE=ACTION_SCRIPT,TYPE=string,DEFAULT_VALUE=/path/to/systemctl_agent.sh"
    ```
4.  Add a new resource using previously specified type.  
    Here I'm using tomcat to demonstrate.  

    ```
    crsctl add resource tomcat01_res \
      -type systemctl_agent_type \
      -attr "SVC_NAME=tomcat,
             PLACEMENT=restricted,
             CARDINALITY=1,
             SERVER_POOLS=*"
	  ```
