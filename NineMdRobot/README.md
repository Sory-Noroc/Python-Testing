### Running the test suite is possible by running the following command in the project root path(./MdNineRobot):
robot --outputdir ./results --variablefile config/production.yaml tests/

#### Running finished smoke tests
robot --outputdir ./results --include smoke --exclude wip --variablefile ./config/dev.yaml tests/
