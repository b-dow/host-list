if(!require(tidyverse)){install.packages('tidyverse', dependencies = TRUE)}
library(tidyverse)



file_01 <- as_tibble(read_csv("https://raw.githubusercontent.com/lightswitch05/hosts/master/docs/lists/tracking-aggressive-extended.txt"))
colnames(file_01)[1] <- "Website"

file_02 <- as_tibble(read_csv("https://raw.githubusercontent.com/lightswitch05/hosts/master/docs/lists/ads-and-tracking-extended.txt"))
colnames(file_02)[1] <- "Website"

file_03 <- as_tibble(read_csv("https://raw.githubusercontent.com/lightswitch05/hosts/master/docs/lists/amp-hosts-extended.txt"))
colnames(file_03)[1] <- "Website"

file_04 <- as_tibble(read_csv("https://raw.githubusercontent.com/lightswitch05/hosts/master/docs/lists/dating-services-extended.txt"))
colnames(file_04)[1] <- "Website"

file_05 <- as_tibble(read_csv("https://raw.githubusercontent.com/lightswitch05/hosts/master/docs/lists/facebook-extended.txt"))
colnames(file_05)[1] <- "Website"

file_06 <- as_tibble(c("0.0.0.0 facebook.com"))
colnames(file_06)[1] <- "Website"

file_07 <- as_tibble(read_csv("https://raw.githubusercontent.com/lightswitch05/hosts/master/docs/lists/tracking-aggressive-extended.txt"))
colnames(file_07)[1] <- "Website"

file_08 <- read_csv("https://raw.githubusercontent.com/kboghdady/youTube_ads_4_pi-hole/master/black.list")
colnames(file_08)[1] <- "Website"
file_08 <- as_tibble(paste0("0.0.0.0 ", file_08$Website))
colnames(file_08)[1] <- "Website"

file_09 <- read_csv("https://raw.githubusercontent.com/justdomains/blocklists/master/lists/adguarddns-justdomains.txt")
colnames(file_09)[1] <- "Website"
file_09 <- as_tibble(paste0("0.0.0.0 ", file_09$Website))
colnames(file_09)[1] <- "Website"





file_10 <- as_tibble(read_csv("https://blocklistproject.github.io/Lists/redirect.txt"))
colnames(file_10)[1] <- "Website"
#file_10 <- as_tibble(c("0.0.0.0 facebook.com"))
#colnames(file_10)[1] <- "Website"


file_11 <- as_tibble(read_csv("https://blocklistproject.github.io/Lists/facebook.txt"))
colnames(file_11)[1] <- "Website"

file_12 <- as_tibble(read_csv("https://blocklistproject.github.io/Lists/ads.txt"))
colnames(file_12)[1] <- "Website"
#file_12 <- as_tibble(c("0.0.0.0 facebook.com"))
#colnames(file_12)[1] <- "Website"

file_13 <- as_tibble(read_csv("https://blocklistproject.github.io/Lists/tracking.txt"))
colnames(file_13)[1] <- "Website"

file_14 <- as_tibble(c("0.0.0.0 facebook.com"))
colnames(file_14)[1] <- "Website"

file_15 <- as_tibble(read_csv("https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn/hosts"))
colnames(file_15)[1] <- "Website"
#file_15 <- file_15 %>% select(-2, -3) 

file_16 <- read_csv("https://v.firebog.net/hosts/Easyprivacy.txt")
colnames(file_16)[1] <- "Website"
file_16 <- as_tibble(paste0("0.0.0.0 ", file_16$Website))
colnames(file_16)[1] <- "Website"

file_17 <- as_tibble(read_csv("https://raw.githubusercontent.com/WorldWideBlock/netguard-block/master/hosts.txt"))
colnames(file_17)[1] <- "Website"


###############################

df <- rbind(file_01,file_02,file_03,file_04,file_05,file_06,file_07,file_08,file_09,file_10,file_11,file_12,file_13,file_14,file_15,file_16,file_17)
df <- df %>% distinct(.keep_all = TRUE)
df$Website <- sub("#.*", "", df$Website)

df <- df %>% 
  distinct() %>%
  filter(!(Website==' @ValbonneConsulting' | 
             Website==' besides' |
             Website==' but it seems to be associated with a phishing attempt on Facebook' |
             Website==' etc.' |
             Website==' JavaScript' |
             Website==' scumbags there.' |
             Website==' this may interfere with some' |
             Website=='127.0.0.1 localhost' |
             Website=='127.0.0.1 localhost.localdomain' |
             Website=='127.0.0.1 local' |
             Website=='255.255.255.255 broadcasthost' |
             Website=='::1 localhost' |
             Website=='::1 ip6-localhost' |
             Website=='::1 ip6-loopback' |
             Website=='fe80::1%lo0 localhost' |
             Website=='ff00::0 ip6-localnet' |
             Website=='ff00::0 ip6-mcastprefix' |
             Website=='ff02::1 ip6-allnodes' |
             Website=='ff02::2 ip6-allrouters' |
             Website=='ff02::3 ip6-allhosts' |
             Website=='0.0.0.0 0.0.0.0')) 




### add custom head

header <- as_tibble(c("127.0.0.1 localhost",
                      "127.0.0.1 localhost.localdomain",
                      "127.0.0.1 local",
                      "255.255.255.255 broadcasthost",
                      "::1 localhost",
                      "::1 ip6-localhost",
                      "::1 ip6-loopback",
                      "fe80::1%lo0 localhost",
                      "ff00::0 ip6-localnet",
                      "ff00::0 ip6-mcastprefix",
                      "ff02::1 ip6-allnodes",
                      "ff02::2 ip6-allrouters",
                      "ff02::3 ip6-allhosts",
                      "0.0.0.0 0.0.0.0"))
colnames(header)[1] <- "Website"



df_toBIND <- rbind(header, df)


write.table(df_toBIND,"00_host.txt",row.names = F,col.names = F,quote = F)