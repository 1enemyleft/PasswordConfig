
# give home path to a variable 
path_home = path.expand("~")

# give credentails path to a variable
path_cred = "/.sys_credentials"

# define a function to get rid of the white space
trim_whitespace <- function( x ) {
  #gsub("(^[[:space:]]+|[[:space:]]+$)", "", x)
  gsub(" ", "", x, fixed = TRUE)
  }

# define a function to remove first and last character 
de_bracket <- function( x ){
  substring(x,2, nchar(x) - 1)
}

profile <- character(); access_username <- character(); access_password <- character()

# combine two paths 
input_file = trim_whitespace(paste(path_home,path_cred))

# read the cred file line by line 
config_file_conn <- file(input_file, open="r")
n <- length(file <- readLines(config_file_conn, n=-1L))
print(n)
close(config_file_conn)

config_file_conn <- file(input_file, open="r")
while (length(file <- readLines(config_file_conn, n=-1L)) > 0) {
  
  for (i in 1:n) {
    if (i%%3==1) {
      profile <- c(profile, de_bracket(file[i]))
    }
    if (i%%3==2 & trim_whitespace(strsplit(file[i],"\\=")[[1]][1])=="username") {
      access_username <- c(access_username, trim_whitespace(strsplit(file[i],"\\=")[[1]][2]))
    }
    if (i%%3==0 & trim_whitespace(strsplit(file[i],"\\=")[[1]][1])=="password")  {
      access_password <- c(access_password, trim_whitespace(strsplit(file[i],"\\=")[[1]][2]))
    }
  }
}
close(config_file_conn)

# combine three vectors into one data frame 
df_credentials = as.data.frame(cbind(profile, access_username, access_password))


get_access_profile <- function() {
  # print all the profiles available 
  print(df_credentials$profile)
}


get_access_username <- function(name="profile_olap_write") {
  # this function reutnrs username that corresponding to the profile name 
  access_id = df_credentials[df_credentials$profile==name,2]
  return(as.character(access_id))
}


get_access_password <- function(name="profile_olap_write") {
  # this function returns password that corresponding to the profile name 
  access_password = df_credentials[df_credentials$profile==name,3]
  return(as.character(access_password))
}
