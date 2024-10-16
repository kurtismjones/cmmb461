#CMMB 461 Microarray Assignment
#Fall 2024
#Copywrite 2024 Kurtis Marno Jones

                                                       #START HERE#####
#In order to run each line of code highlight that line and click run or highlight that line and press control+enter (Windows) or 
#command+enter (Mac). You DO NOT need to know how to code for this part of the assignment simply follow along with the comment on the right and
#fill in the text that the prompt tells you to. Each line of code MUST be run and MUST be run in the order it was written.

                                                            

                                                            
                                                                                                                      
                                                    #INSTALLING PACKAGES#### 
#The first step to use R for normalization and clustering of Microarray Data is to install several add-ons that R calls "PACKAGES". 



install.packages("RCurl")                                  #The default way to install PACKAGES is by using the install.packages function 
                                                           #this is built into base R and works for many commonly used PACKAGES.

                                                           #However, there are some specialized programs that we want to use that are only 
                                                           #available through a 3rd party installer called BioConductor.

install.packages("PACKAGE_NAME_HERE")                      #Type BiocManager where it says PACKAGE_NAME_HERE using the same capitalization. 
                                                           #Then press Control + Enter (on Windows) or Command + Enter (on Mac).

library(BiocManager)                                       #Installing a package is only the first step. To load or turn on packages, we use
                                                           #the library function.

BiocManager::install(pkgs =  c("marray","ctc",             #This first line tells R to go find the PACKAGES listed in the "". The c() 
                               "tidyverse","ape"),               #command tells r that this is a list of multiple items; the "" around each 
                     force=TRUE, update=TRUE, ask=FALSE)   #tells R that the item is a text string and not another function or vector
                                                           #that R needs to look for.

library(ENTER_HERE)                                        #The library function can only load one function at a time, so we need to use it
library(ENTER_HERE)                                        #multiple times to load all of the packages we just installed. Enter each of the 
library(ENTER_HERE)                                        #4 packages we just installed from Bioconductor (marray, ctc, tidyverse, and ape). 
library(ENTER_HERE)                                        #Only enter one package for each of the library functions.



                                                      #******IMPORTANT*****
                                                    
#At this point, you must set your working directory (the default place R will look for files) before continuing. To do this, click on the 
#"Files" tab in the bottom right window pane; this should show a list of files in the default location where the working directory is set. 
#Using this window, navigate to the folder where your files are stored. Once you are there, click on "More" (it has a picture of a gear next 
#to it) and then "Set As Working Directory". 

                            #ONLY MOVE ON TO THE NEXT STEPS ONCE YOU HAVE SET YOUR WORKING DIRECTORY





                                                      #VARIABLES####

#Enter Your First and Last Name below between the ' ' DO NOT DELETE these:

First.Name <- 'FIRST_NAME_HERE'                            #Once you have entered your first and last name we will practice storing them as 
Last.Name  <- 'LAST_NAME_HERE'                             #VARIABLES.In R VARIABLES are used to store information for easy use later. 
                                                           #VARIABLES it can be a simple as a single word/number or a list of words/numbers
                                                           #or as complex as a large file with many dimensions and subcategories. We can tell R to
                                                           #save something as a VARIABLE by adding <- before the what is is we want to save
                                                           #usually this is some sort of function (a command that is doing something) but it can 
                                                           #also just a simple word/number. Then at the beginning before the '<-' we specify the 
                                                           #name of the variable we are saving.

                                                           #Run the two lines to create the VARIABLES 'First.Name' and Last.Name
                                                           #Look in the top right quadrant and under the Environment tab below the heading 'Values'
                                                           #You should see the two new VARIABLES appear with your name next to them.

                              #CONGRADULATIONS! You have made your first VARIABLE!





                                          #READING THE DATA FILES AND LOADING INTO R####
#The second step whenever you use R is to read the files containing your data. This can anything be a single file from a single experiment
#that is stored locally on your computer to a large dataset downloaded directly from somewhere like NCBI. In our case we will loading some raw microarray data
#store on the GitHub server that this code is from.

  #The main package used here is marray which includes functions for reading raw microarray data, normalization, and various summary methods for visualizing
  #the processed data.

                                                           #The first thing that needs to be done is to read a data file that describes
                                                           #the conditions and names of each of our microarray experiments.

Targets <- read.marrayInfo("PombeExperiment.txt")          #To do this, we use the read.marrayInfo function and specify the file name within the ("").
                                                           #and save this information as the VARIABLE 'Targets'

raw.microarray<-read.Spot(targets = Targets)               #Now that we have information on the experiment saved as Targets, we can read the
                                                           #raw microarray data. This experiment included 4 microarray slides, 1 for each 
                                                           #treatment each was saved as a .spot file. 

                                                           #To read the raw microarray files, we use the read.Spot function 

                                                           #then using the information we just saved in the VARIABLE 'Targets' specify which 
                                                           #files to read. We'll save the data read from the files as a new VARIABLE 'raw.microarray'. 
                                                                                                                                  #***Hint HINT***

microarray.info<-read.Galfile("pombe.gal")                 #When the raw data is read, there isn't any information on the layout of the
                                                           #specific array used. A .gal file provides this information. Using the 
                                                           #read.Galfile function we can read the .gal file for this experiment and save
                                                           #it as 'microarray.info'.

microarray.info$gnames@maInfo$Name[1631]<-tolower(         #To ensure that our experiment is run with specificity to us the raw.microarray
      paste(str_sub(First.Name,start=1L,end=2L),           #file can be updated using '<-' 
      str_sub(Last.Name,start=1L,end=2L),'4',sep = ''))

    raw.microarray@maLayout<-microarray.info$layout        #We overwrite the default maLayout and maGnames values with those we saved in 
    raw.microarray@maGnames<-microarray.info$gnames        #'microarray.info' to update this information.


    


                                                   #NORMALIZATION####
#When the raw data was imported, the marray package automatically Log2 transformed the data; however, we must still carry out the remaining 
#pre-processing steps before analyzing the data.
    
#Normalization with marray is very easy as all our raw microarrays are saved as one VARIABLE. Because of that marray can preform normaliztion on 
#all four arrays with a single command. 
    
normalized.array<-maNormMain(                              #The base marray normalization function is maNormMain and we will save this as a new
                                                           #VARIABLE 'normalized.array'
  
                              VARIABLE_NAME,               #Next we need specify what is it that we want to normalize in this case it will be the
                                                           #data we just imported into R. Recall the VARIABLE that we saved the raw microarray data as
                                                           
                                                           #Replace where is says VARIABLE_NAME with the VARIABLE for the raw microarray data
                                                           #!!!!!IMPORTANT leave the comma after VARIABLE_NAME so that we can specify more parameters!!!!
                             
                              
                              f.loc = list(maNormLoess())) #The other command we add is f.loc=list(maNormLoess()) this function tells R what type
                                                           #of normalization to run on our data.                      




    
                                                  #SCATTER PLOTS####
#One helpful tool we have to visualize the effect of normalization is M-A plots. M-A plots allow us to visualize the variations in the data.
      
  ##Setting File Parameters####   
  #Usually, when plotting in R, the plot will just be displayed in a window. However, we want to save these plots to view them later. 
    
    pdf(                                                   #To do that, we can use the pdf function,   
      
         width=8.5, height = 11,                           #then we specify the physical size of the pdf in inches using width= and height=.
    
         file="FILE_NAME_HERE")                            #Finaly we give the file a name using "file='...'" change the name of the saved 
                                                           #file where it says FILE_NAME_HERE to be MA-Plots followed by your name, then .pdf
    
  par(                                                     #To place multiple plots on one page, we need to change the parameters of how R generates
                                                           #what goes on each page of the pdf (the plot output) by changing the some parameters
                                                           #This is done by using the command par. 
                                                           
                                                           #Within this we specify that we want the page to be made up of 2 rows and 1 column worth of 
        mfrow=c(2,1))                                      #plots using mfrow=c(2,1)
  
  
  
    ###Pre-Normalization####
    #The first plot we want to make is the MA plot of the pre-normalized data. Making a plot in r is fairly straightforward. 
  
    plot(                                                  #To make a plot we will use the plot command,
         
         raw.microarray[,1],                               #then specify what data we want to plot (in this case, the first microarray experiment 
                                                           #given by 'raw.microarray[,1]' representing the Gene A Deletion Experiment)
         
         xvar="maA", yvar="maM",zvar="maPrintTip",         #Next specify the each of the X,y and Z Variables/Labels. Note that each subsequent parameter                                            
                                                           #is separated by a comma 
                                                            
         legend.func = NULL,                               #We remove the legend by setting legend.func = to NULL,

         ylim = c(-3.5,3.5),                               #Set the Y axis limits of the plot to -3.5 and +3.5
                                                           
                                                           #And finally give our plot a title (using the main = parameter).Replace "PLOT_TITLE_HERE          
         main="PLOT_TITLE_HERE")                           #and give this plot an appropriate title.
  
    
    abline(h = 2)                                          #Lastly, we will add a horizontal line at +2 and -2 to show our two-fold change 
    abline(h = -2)                                         #cut-off.
    
    ###Post-Normalization####
    
    plot(
         normalized.array[,1],                             #We repeat the same process as above but using the 'normalized.array' data for the 
         xvar="maA", yvar="maM", zvar="maPrintTip",        #same treatment but now using the post-normalization data.
         legend.func = NULL,
         ylim= c(-3.5,3.5),
         
         main="PLOT_TITLE_HERE")                           #Give this second plot a title as well.
    
    abline(h = 2)
    abline(h = -2)
  
    
  ##Saving the File####
  #!!!!IMPORTANT!!!!!
    
  dev.off()                                                #Once our plots are complete, we can use the dev.off() function to save to the pdf 
                                                           #file we specified above and return r to its default plot output window.If this function is
                                                           #not run you will end up with a blank PDF or if you run the code for making each of the plots 
                                                           #above multiple times before running this you will end up with too many plots being made!

  
  
  
   
                                          #SUMMARIZING EXPRESSION VALUES####
  
  ##Generating Summary Data####
  #In addition to the two plots, we also want to save the processed expression values for each gene.
  
expression.data<-as.data.frame(normalized.array@           #The first step is to extract just the expression values from the 'normalized.array' 
                         maM[49:4200,], na.omit=TRUE)      #VARIABLE. To do that, we simply have to specify what part of the array we want and 
                                                           #save that as the new VARIABLE 'expression.data' as a table of values.
  
  row.names(expression.data)<-normalized.array@            #Unfortunately, the row names and column names are not extracted at the same time,
                        maGnames@maInfo$Name[49:4200]      #so we need to define these both, extracting the gene names from the array and the 
                                                           #column names from the experiment description.
  colnames(expression.data)<-Targets@maInfo$Names
  
  names<-rownames(expression.data)                         #These two lines add a new column at the begging and copy the row names (genes) 
  expression.data<-cbind(names,expression.data)            #into it; this is important for clustering later.
  
  
  ##Exporting a Data File####
  
write.csv(expression.data[2:5],                            #The last step is to export the data save in the VARIABLE 'expression.data' as a CSV file

          "FILE_NAME_HERE.csv")                            #Change the name of the file to be Expression_Values followed by your name, then .csv





                                                    #CLUSTERING####
  
  ##Filtering and setting a cut-off value####
  #The first step in clustering is filtering the data to only include values that show a fold change of 2 or greater (two-fold increase or decrease). 

expression.data.filtered<-filter_at(                       #To filter the data, we use the filter_at function and set it to save this as the VARIABLE
                                                           #'expression.data.filtered'
                                
                                  expression.data,         #The first thing we need to indicate which data we want to filter in this case the information 
                                                           #stored in the VARIABLE 'expression.data' 

                                  vars(starts_with("g")),  #Second, we define what parts of the data we want to filter by, in this case, any column 
                                                           #starting with g (for gene), which are our 4 treatments.
                                  
                                  any_vars((abs(.)>2)))    #Lastly, we define how we want to filter
                                                           # -any_vars tells the filter function that we want any row that at least one of  
                                                           #  columns meets the filtering criteria 
                                                           #   -abs(.) indicates that the absolute value should be used so that both + and - value are seen
                                                           #    -'>2' tells the filter function to filter for values greater than 2.
  

  ##Clustering Function####
  #Clustering takes place 2-dimensionally clustering both by row (gene) and by column (treatment).


hr <- hcluster(                                            #We use the hcluster function for both; for the rows (genes) we will save this as the VARIABLE 'hr' 
                                                           
               expression.data.filtered[2:5],              #Next, as usual, we define what VARIABLE contains data we want to use.
               
               method = "ENTER_METHOD_HERE",               #Next, we indicate what clustering method we wish to use; in this case, we will use pearson clustering
                                                           #Change where it says ENTER_METHOD_HERE to the method we are using (pearson) - CASE SENSITIVE!
               
               link = "ENTER_LINKAGE_TYPE_HERE")           #Lastly, we define what linkage we want to use.For this, we will use average linkage.
                                                           #Change where it says ENTER_LINKAGE_TYPE_HERE to the linkage we are using (average) - CASE SENSITIVE!
                                                         

hc <- hcluster(                                            #To cluster columns, we use the same function but need to swap the rows and columns 
                                                           #of the data as the hcluster only works on rows.We will save this as the VARIABLE 'hc'
  
               t(expression.data.filtered[2:5]),           #Thankfully this is quickly done by adding a 't' in front of the data.
               
               method = "ENTER_METHOD_HERE",               #We will use the same clustering method as used for the rows.
                                                           #Change where it says ENTER_METHOD_HERE to the method we are using (pearson) - CASE SENSITIVE!
               
               link = "ENTER_LINKAGE_TYPE_HERE")           #Similarly we will use the same linkage as used for the rows.
                                                           #Change where it says ENTER_LINKAGE_TYPE_HERE to the linkage we are using (average) - CASE SENSITIVE!


  ##Saving Cluster files used to create Heatmap####
  #There are 3 files that are needed to make the heatmap. A text file that contains the information for the row dendrogram (clustering); 
  #a text file that contains the information for the column dendrogram (clustering), and a text file which contains the expression values
  #and labeling information.

write.tree(as.phylo(hr),file='gene-expression-clustered_row_clusters.txt')

write.tree(as.phylo(hc),file='gene-expression-clustered_column_clusters.txt')

  colnames(expression.data.filtered)<-c("NAME",colnames(expression.data.filtered[,2:5]))
  UNIQID<-rownames(expression.data.filtered)                         
  expression.data.filtered<-cbind(UNIQID,expression.data.filtered)
write.table(expression.data.filtered,file='gene-expression-clustered.txt',sep='\t',row.names=FALSE,quote=FALSE,col.names = TRUE)

