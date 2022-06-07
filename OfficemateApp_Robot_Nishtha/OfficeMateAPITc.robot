*** Settings ***
Library  RequestsLibrary
Library  Collections

Test Setup  Create Session Test

*** Variables ***
${base_url}     https://www.officemate.co.th/en

*** Test Cases ***
API TC01: Get Request of homepage and validate the response code is OK
    [Tags]   API
    [Documentation]   Send query to api https://www.officemate.co.th/en/
    Create Session  mysession  https://officemate.co.th/en  verify=False
    ${headers}=    Create Dictionary    Accept=application/json    Content-Type=application/json    charset=utf-8
	${response}=    Get On Session    mysession  /  headers=${headers}
    Status Should Be  200  ${response}


API TC02: Get Request Search with login details and validate the response code should not be 404.
    [Tags]   API
    [Documentation]   Send query to api https://officemate.co.th/en/search?mobile.
    ...               It only accepts https://officemate.co.th/en/search/mobile
    Create Session  mysession  https://officemate.co.th/en
    ${data}=    Create Dictionary    email: "nishtha.shradha@gmail.com"    password: "test"
    ${response} =    POST On Session  mysession  /api/login json=${data}
    Status Should Be  401  ${response}  #Check Status as 200
    

API TC03: Get Request of homepage Search and validate the response code is OK
    [Tags]   API
    [Documentation]   Send query to api https://www.officemate.co.th/en/search/books.
    ...               It only accepts https://officemate.co.th/en/search/books
    Create Session  mysession  https://officemate.co.th/en  verify=False
    ${headers}=    Create Dictionary    Accept=application/json    Content-Type=application/json    charset=utf-8
	${response}=    Get On Session    mysession  /search/books
    Status Should Be  200  ${response}

API TC04: Get Request of homepage Search with % and validate the response code should not be 404.
    [Tags]   API
    [Documentation]   Send query to api https://officemate.co.th/en/search?mobile.
    ...               It only accepts https://officemate.co.th/en/search/mobile
    ${response} =    Get On Session  mysession  /search/%
    Should Not Contain   '${response.status_code}'   '404'   #Check Status as 200

API TC05: Post Request of homepage login
    Create Session Test 
    &{data}=    Create dictionary  email: "nishtha.shradha@gmail.com"    password: "test"       
    ${resp}=    POST On Session    mysession  /api/login ${data}     
                                                                                                       
    Status Should Be                 200  ${resp}

API TC06: Post Request of homepage AddToCart
    Create Session Test 
    &{data}=    Create dictionary  sku: "OFMD000036"    qty: 1  cartId: 85840390    c=ccc       
    ${resp}=    POST On Session    mysession  /api/cart/addToCart ${data}     
                                                                                                       
    Status Should Be                 200  ${resp}  


API TC07: GET Request of homepage Order History
    [Tags]   API
    Create Session  mysession  https://officemate.co.th/en  verify=False
    ${headers}=    Create Dictionary    Accept=application/json    Content-Type=application/json    charset=utf-8
	${response}=    Get On Session    mysession  /api/account/order-history
    Status Should Be  200  ${response}               

*** Keywords ***
Create Session Test
    Create Session  mysession  https://officemate.co.th/en

Create POST REQUEST
    [Arguments]   ${session}  ${endpoint}   ${params}=${none}
    ${headers}=    Create Dictionary    Accept=application/json    Content-Type=application/json    charset=utf-8
	${response}=   Post Request    ${session}    ${endpoint}  params=${params}
    ${reponse}
	[Return]   ${response}
