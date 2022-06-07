*** Settings ***
Library           Selenium2Library

*** Variables ***
#${iframe} xpath://div/iframe[1] 

*** Test Cases ***
Dismiss Alert
[Documentation] This testcase is for dismissing the alert and Image pop-up
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
[Documentation] This test case is for searching the specific SKU
    Input Text  xpath://input[@data-testid='txt-SearchBar']    OFM5010630
    Click Element   xpath://div[@id='btn-searchResultPage']
    Wait Until Element Is Visible      xpath://div[@data-testid='pnl-ListPage']
    Capture Page Screenshot

TC03 Verify Search popup result
[Documentation] This test case is for validating the search result based on specific item
    Enter a Search text   
    Click Element   xpath://div[@id='btn-searchResultPage']
    Wait Until Element Is Visible      xpath://div[@data-testid='pnl-ListPage']
    Capture Page Screenshot

TC04 Verify Search with xxxxxxxxxx and not found
[Documentation] This test case is for validating the search result based on specific item
    Input Text  xpath://input[@data-testid='txt-SearchBar']    xxxxxxxxxx
    Click Element   xpath://div[@id='btn-searchResultPage']
    sleep   5s
    Wait Until Element Is Visible   //div[@id='pnl-listPageNotFound']//div[@class='title']
    Run keyword and continue on failure  fail  this is also a failure

    Capture Page Screenshot

TC09 Verify Search with % and not found (Failed)
[Documentation] This test case is for validating the search result based on specific item
    Input Text  xpath://input[@data-testid='txt-SearchBar']    %
    Click Element   xpath://div[@id='btn-searchResultPage']
    Wait Until Element Is Visible   //div[@id='pnl-listPageNotFound']//div[@class='title']
    Capture Page Screenshot

TC06 Verify Promotions and Priviledges window
     Click Element  xpath://a[@id='lnk-promotionPage']/span[contains(text(),'Promotions and Privileges')]
     #${my_string}  Get Text  xpath://a[@id='pnl-shop-template01-10076']/img
     Wait Until Element Is Visible  xpath://div/h1[contains(text(),'Promotions & Privileges')]
     Capture Page Screenshot

TC07 Verify navigation to Ink Search
[Documentation] This test case is for checking the navigation link from homepage once Ink Search is clicked
    Wait Until Element Is Visible   xpath://div/a[@id='lnk-inkSearchPage'][@data-testid='btn-viewMainHeader-InkSearch']   
    Click Element   xpath://div/a[@id='lnk-inkSearchPage'][@data-testid='btn-viewMainHeader-InkSearch']
    Wait Until Element Is Visible   xpath://div/h1[contains(text(),'Search for ink')]
    Capture Page Screenshot

TC08 Verify Login button
[Documentation] This test case is for validating the login page

    Click Element  xpath://div/a[text()='LOG IN']
    Wait Until Element Is Visible  xpath://div[@id='login-page']
    Capture Page Screenshot

TC09 Verify Register button
[Documentation] This test case is for validating the Registeration page
     Click Element  xpath://span/a[contains(text(),'REGISTER')]
     Wait Until Element Is Visible  xpath://div/h1[text()='Create your OfficeMate account']
     Capture Page Screenshot

TC01 Verify Mini Cart
[Documentation] This test case is for validating the cart on Home Page
     Click Element  xpath://div[@data-testid='btn-MiniCart']
     Wait Until Element Is Visible  xpath://div[@id='mini-cart']
     Capture Page Screenshot

[Teardown]     Close Browser

***Keywords***
Enter a Search text
    # these are pre-defined Selenium2Library keywords
   # wait until element is visible    id=username_input
    Input Text  xpath://input[@data-testid='txt-SearchBar']    Post it
