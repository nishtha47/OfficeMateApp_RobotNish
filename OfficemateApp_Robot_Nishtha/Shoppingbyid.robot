*** Settings ***
Library  Selenium2Library
Library  RequestsLibrary
Library  Collections

#Test Setup  Create Session Test

*** Variables ***
${base_url}     https://www.officemate.co.th/en

*** Test Cases ***

Dismiss Alert
    ${chromeOptions}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${exclude}=    Create Dictionary    "fasp"=True
    ${prefs}=    Create Dictionary    protocol_handler.excluded_schemes=${exclude}
    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${chromeOptions}
     Open Browser    https://www.officemate.co.th/en    chrome
    #Handle Alert    timeout=60s
    #Alert should be present
    Sleep   5s
    Select Frame    xpath://div/iframe[1]
   # Wait Until Element Is Visible   xpath://div[@id='image-1654076885133']
    Wait Until Element Is Visible   xpath://img[@class='element-image']
    Click Element   xpath://img[@class='element-image']  
  #  Sleep   5s
   
Shop by Product id
   #Input Text  xpath://input[@data-testid='txt-SearchBar']    Post It
    Wait Until Element Is Visible   xpath://a[@data-testid='pnl-EnhanceLink'][6]
    Click Element   xpath://a[@data-testid='pnl-EnhanceLink'][6]
    Sleep   5s
    Select Frame    xpath://div/iframe[1]
    Log To Console  Frame is selected
    Wait Until Element Is Visible  xpath://img[@class='element-image']  
    Click Element   xpath://i[@class='fa fa-times element-close-button']
    Sleep   5s
    Run Keyword And Ignore Error    Scroll Element Into View    xpath://*[text()='Shop by product ID']
    Sleep   5s
    Wait Until Element Is Visible   xpath://*[text()='Shop by product ID']   
    Click Element   xpath://*[text()='Shop by product ID']
    Sleep   5s
    Input Text  xpath://input[@id='txt-Cart-AddBySKU']  OFM5010630
    Click Element   xpath://div[@id='btn-Cart-AddBySKU']
    Sleep   5s
    Wait Until Element Is Visible   xpath://div[@id='btn-cartToCheckoutPage']
    Sleep   5s





