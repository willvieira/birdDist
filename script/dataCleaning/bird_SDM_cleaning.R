#####################################################
##
## change multiple bird script to combined bird csv
##
####################################################

#fix MOCH
mountainchickadee <-read.table("C:\\Users\\anarahlin\\Desktop\\birdSDMcoordinates\\mountain_chick_csv.csv", header = TRUE, sep = ",")

head(mountainchickadee)

mountainchickadee<-setNames(mountainchickadee, c("species", "lat", "long")) #hooray it's fixed

MOCH<-na.omit(mountainchickadee)

MOCH<- unique(MOCH)

#fix Mountain bluebird MOBL

mountainbluebird <-read.table("C:\\Users\\anarahlin\\Desktop\\birdSDMcoordinates\\mountain_bluebird_csv.csv", header = TRUE, sep = ",")

head(mountainbluebird)
mountainbluebird<-setNames(mountainbluebird, c("species", "lat", "long")) #hooray it's fixed

MOBL<-na.omit(mountainbluebird)

MOBL<- unique(MOBL)

#fix the Lewis's woodpecker LEWO

lewiswoodpecker <-read.table("C:\\Users\\anarahlin\\Desktop\\birdSDMcoordinates\\lewis_wp_csv.csv", header = TRUE, sep = ",")

head(lewiswoodpecker)

lewiswoodpecker<-setNames(lewiswoodpecker, c("species", "lat", "long")) #hooray it's fixed

LEWO<-na.omit(lewiswoodpecker)

LEWO<- unique(LEWO)

#fix housewren data

housewren <-read.table("C:\\Users\\anarahlin\\Desktop\\birdSDMcoordinates\\house_wren_csv.csv", header = TRUE, sep = ",")

head(housewren)

housewren<-setNames(housewren, c("species", "lat", "long")) #hooray it's fixed
HOWR<-na.omit(housewren)

HOWR<- unique(HOWR)

#fix black-backed woodpecker BBWO


black <-read.table("C:\\Users\\anarahlin\\Desktop\\birdSDMcoordinates\\black_back_wp_csv.csv", header = TRUE, sep = ",")

head(black)

black<-setNames(black, c("species", "lat", "long")) #hooray it's fixed
BBWO<-na.omit(black)

BBWO<- unique(BBWO)

allbird<- rbind(HOWR,BBWO,LEWO,MOCH,MOBL) #rbind all cleaned scripts together

plot(allbird$long, allbird$lat) #what's the lat long plot look like?

head(allbird)

write.csv(allbird,file = "C:\\Users\\anarahlin\\Desktop\\birdSDMcoordinates\\allbird_unique.csv", row.names = FALSE)


