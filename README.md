# PasswordConfig
#### 1. make sure .sys_credentials file exist in your home directory following the format like below: 

    [profile_name]
    username = ---
    password = ---  
    
#### 2. Install devtools package
    install.packages("devtools")
    
#### 3. Install PasswordConfig package from github repo
    devtools::install_github("1enemyleft/PasswordConfig")

#### 4. Example of how to use this package: 
    get_access_username("profile_name")
    get_access_password("profile_name")
