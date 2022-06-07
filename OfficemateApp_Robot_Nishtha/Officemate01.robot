*** Settings ***
Library    SeleniumLibrary

***Test Cases ***

Pre-requisite Go to URL
    Open Browser    https://www.officemate.co.th/en    chrome

Dismiss Alert
    [Tags]  UICase
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

TC01 Verify Search with "Post It"
    Handle Alert    action=DISMISS    timeout=60 s
    Wait Until Element Is Visible   xpath://div[@id='image-1654076885133']
    close   xpath://i[@class='fa fa-times element-close-button']
    Input Text  xpath://input[@data-testid='txt-SearchBar']    Post It
    Click Element   xpath://div[@id='btn-searchResultPage']

    #TODO Able to close Popup

    Wait Until Element Is Visible      xpath://div[@data-testid='pnl-ListPage']
    Capture Page Screenshot
    Wait Until Location Is Not      https://www.officemate.co.th/en     20
    Go Back

TC02 Verify Search with SKU: MKP0344596
    Input Text  xpath://input[@data-testid='txt-SearchBar']    MKP0344596
    Click Element   xpath://div[@id='btn-searchResultPage']
    Wait Until Element Is Visible      xpath://div[@data-testid='pnl-ListPage']
    Capture Page Screenshot

TC03 Verify Search popup result
    Input Text  xpath://input[@data-testid='txt-SearchBar']    Post It
    Wait Until Element Is Visible      xpath://div[@data-testid='pnl-ListPage']
    Capture Page Screenshot

TC04 Verify Search with xxxxxxxxxx and not found
    Input Text  xpath://input[@data-testid='txt-SearchBar']    xxxxxxxxxx
    Click Element   xpath://div[@id='btn-searchResultPage']
    Wait Until Element Is Visible   //*[@id="pnl-listPageNotFound"]
    Capture Page Screenshot

TC09 Verify Search with % and not found (Failed)
    Input Text  xpath://input[@data-testid='txt-SearchBar']    %
    Click Element   xpath://div[@id='btn-searchResultPage']
    Wait Until Element Is Visible   //*[@id="pnl-listPageNotFound"]
    Capture Page Screenshot


