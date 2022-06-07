*** Settings ***
Library    SeleniumLibrary  
Library    HttpLibrary.HTTP
Library    OperatingSystem
Library    Collections

*** Keywords ***

*** Test Cases ***
TestAddJSONObjectByJSONPath
    ${file}    Get File    testdataproduct.json
 
     
| | # convert the data to a python object
| | ${object}= | Evaluate | json.loads('''${file}''') | json
| | 
| | # log the data
| | log | Hello, my name is ${object["firstname"]} ${object["lastname"]} | WARN