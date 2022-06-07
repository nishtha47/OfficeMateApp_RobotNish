*** Settings ***
Library           Selenium2Library


*** Variables ***
#${iframe} xpath://div/iframe[1] 

*** Test Cases ***
Dismiss Alert
    ${chromeOptions}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${exclude}=    Create Dictionary    "fasp"=True
    ${prefs}=    Create Dictionary    protocol_handler.excluded_schemes=${exclude}
    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${chromeOptions}
     Open Browser    https://www.officemate.co.th/en    chrome
    Sleep   5s
    Select Frame    xpath://div/iframe[1]
    Wait Until Element Is Visible   xpath://img[@class='element-image']
    Click Element   xpath://img[@class='element-image'] 
    ${present}=  Run Keyword And Return Status    Element Should Be Visible   xpath://div[@id='close-button-1454703945249']/i
    Run Keyword If    ${present}    Closebutton
    Wait Until Element Is Visible   xpath://input[@data-testid='txt-SearchBar']
    Input Text  xpath://input[@data-testid='txt-SearchBar']    Post It
    Click Element   xpath://div[@id='btn-searchResultPage']

TC02 Verify Search with SKU: MKP0344596
    Input Text  xpath://input[@data-testid='txt-SearchBar']    MKP0344596
    Click Element   xpath://div[@id='btn-searchResultPage']
    Wait Until Element Is Visible      xpath://div[@data-testid='pnl-ListPage']
    Capture Page Screenshot

TC03 Verify Search popup result
    Input Text  xpath://input[@data-testid='txt-SearchBar']    Post It
    Click Element   xpath://div[@id='btn-searchResultPage']
    Wait Until Element Is Visible      xpath://div[@data-testid='pnl-ListPage']
    Capture Page Screenshot

TC04 Verify Search with Category
    Input Text  xpath://input[@data-testid='txt-SearchBar']     Books
    Click Element    xpath://div[@id='btn-searchResultPage']
    Wait Until Element Is Visible      xpath://div[@data-testid='pnl-ListPage']
    Capture Page Screenshot

TC05 Verify Search with Number
    Input Text  xpath://input[@data-testid='txt-SearchBar']     12
    Click Element    xpath://div[@id='btn-searchResultPage']
    Wait Until Element Is Visible      xpath://div[@data-testid='pnl-ListPage']
    Capture Page Screenshot

TC06 Verify Search with Brand
    Input Text  xpath://input[@data-testid='txt-SearchBar']     CCU
    Click Element    xpath://div[@id='btn-searchResultPage']
    Wait Until Element Is Visible      xpath://div[@data-testid='pnl-ListPage']
    Capture Page Screenshot

TC07 Verify Search results
    Input Text  xpath://input[@data-testid='txt-SearchBar']     Books
    Wait Until Element Is Visible      xpath://div[@data-testid='pnl-ListPage']
    @{Searchresult}=  Get WebElements  xpath://div[contains(text(),'product results')]
    ${count}=   Get Element Count   xpath://div[@data-testid='pnl-productGrid']/div
    Run Keyword If  '${count}'>'0'  Log To Console  This contains search results 
    Run Keyword if  '${count}'<'0'  Log To Console  No Search products found 
   
TC08 Verify Search with special character
    Input Text  xpath://input[@data-testid='txt-SearchBar']    %  
    Click Element    xpath://div[@id='btn-searchResultPage']
    @{Searchresult}=  Get WebElements  xpath://div[contains(text(),'product results')]
    ${count}=   Get Element Count   xpath://div[@data-testid='pnl-productGrid']/div
    Run Keyword If  '${count}'>'0'  Log To Console  This contains search results 
    Run Keyword if  '${count}'<'0'  Log To Console  No Search products found 
    Capture Page Screenshot

TC09 Verify Search with specific item
    Input Text  xpath://input[@data-testid='txt-SearchBar']    Thai Books  
    Click Element    xpath://div[@id='btn-searchResultPage']
    Wait Until Element Is Visible   xpath://div[contains(text(),'product results')]
    @{Searchresult}=  Get WebElements  xpath://div[contains(text(),'product results')]
    ${count}=   Get Element Count   xpath://div[@data-testid='pnl-productGrid']/div
    Capture Page Screenshot
    Should Be Equal As Integers   ${count}   45
   
    Capture Page Screenshot    

[Teardown]     Close Browser