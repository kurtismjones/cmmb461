
#Student Name: ENTER_NAME_HERE
#CMMB 461 Microarray Assignment
#Fall 2023
#Copywrite 2023 Kurtis Marno Jones

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
                               "tidyverse"),               #command tells r that this is a list of multiple items; the "" around each 
                     force=TRUE, update=TRUE, ask=FALSE)   #tells R that the item is a text string and not another function or vector
                                                           #that R needs to look for.

library(ENTER_HERE)                                        #The library function can only load one function at a time, so we need to use it
library(ENTER_HERE)                                        #multiple times to load all of the packages we just installed. Enter each of the 
library(ENTER_HERE)                                        #3 packages we just installed from Bioconductor (marray, ctc, and tidyverse). 
                                                           #Only enter one package for each of the library functions.





#READING THE DATA FILES AND LOADING INTO R####
  #The second step whenever you use R is to read the files containing your data. This can anything be a single file from a single experiment
  #that is stored locally on your computer to a large dataset downloaded directly from somewhere like NCBI.


                                                      #******IMPORTANT*****
                                                    
#At this point, you must set your working directory (the default place R will look for files) before continuing. To do this, click on the 
#"Files" tab in the bottom right window pane; this should show a list of files in the default location where the working directory is set. 
#Using this window, navigate to the folder where your files are stored. Once you are there, click on "More" (it has a picture of a gear next 
#to it) and then "Set As Working Directory". 

                            #ONLY MOVE ON TO THE NEXT STEPS ONCE YOU HAVE SET YOUR WORKING DIRECTORY




                                                           #The main package used here is marray which includes functions for reading  
                                                           #raw microarray data, normalization, and various summary methods for visualizing
                                                           #the processed data.

Targets <- read.marrayInfo("PombeExperiment.txt")          #The first thing that needs to be done is to read a data file that describes
                                                           #the conditions and names of each of our microarray experiments. To do this, we  
                                                           #use the read.marrayInfo function and specify the file name within the ("").
                                                           #If we want to save this information for easy use later, we can tell R to save it
                                                           #as a VARIABLE by adding <- before the function and adding what we want to name it
                                                           #at the beginning.

microarray.raw<-read.Spot(targets = Targets)               #Now that we have information on the experiment saved as Targets, we can read the
                                                           #raw microarray data. This experiment included 4 microarray slides, 1 for each 
                                                           #treatment each was saved as a .spot file. To read the files, we use the read.Spot
                                                           #function and specify which files to ready by using the information saved in
                                                           #'Targets'. We'll save this information as the VARIABLE 'microarray.raw'.

microarray.info<-read.Galfile("pombe.gal")                 #When the raw data is read, there isn't any information on the layout of the
                                                           #specific array used. A .gal file provides this information. Using the 
                                                           #read.Galfile function we can read the .gal file for this experiment and save
                                                           #it as 'microarray.info'.

    microarray.raw@maLayout<-microarray.info$layout        #We overwrite the default maLayout and maGnames values with those we saved in 
    microarray.raw@maGnames<-microarray.info$gnames        #'microarray.info' to update this information.

    
    


#NORMALIZATION####
  #When the raw data was imported, the marray package automatically Log2 transformed the data; however, we must still carry out the remaining 
  #pre-processing steps before analyzing the data.
    
    
     
normalized.array<-maNormMain(VARIABLE_NAME,                #Normalization with marray is very easy as all our arrays are saved as one
                          f.loc = list(maNormLoess()))     #VARIABLE marray can go about normalizing all four of our different arrays with a     
                                                           #single command. The base marray normalization function is maNormMain. To specify
                                                           #which VARIABLE we want to run the normalization on, we define it by typing its 
                                                           #name followed by a comma so that we can add additional information after.
                                                           
                                                           #Enter the VARIABLE information for the raw microarray data that we just imported
                                                           #as we saved it where it says VARIABLE_NAME.
    
                                                           #The second command we add is f.loc=list(maNormLoess()) this function tells R
                                                           #what type of normalization to run on our data. This is all saved as a new VARIABLE
                                                           #called 'normalized.array'.

    
##Scatter plots####
  #One helpful tool we have to visualize the effect of normalization is M-A plots. M-A plots allow us to visualize the variations in the data.
      
    
  pdf(file="FILE_NAME_HERE.pdf",                           #Usually, when plotting in R, the plot will just be displayed in a window. However,
    width = 8.5,                                           #we want to save these plots to view them later. To do that, we can use the pdf  
    height = 11)                                           #function, specify the name and the size of the pdf in inches. 
                                                           
                                                           #Change the name of the saved file to be MA-Plots followed by your name, then .pdf
    
    
  par(mfrow=c(2,1))                                        #To place multiple plots on one page, we need to change the parameters of the plot
                                                           #output using par. Here we specify using mfrow=c(2,1) that we want 2 rows and 
                                                           #1 column.
  
###Pre-Normalization####
    plot(microarray.raw[,3], xvar="maA", yvar="maM",       #The first plot we want to make is the MA plot of the pre-normalized data. Plotting
         zvar="maPrintTip",                                #in r is fairly straightforward. Using the plot command, we specify what data we 
         legend.func = NULL,                               #want to plot (in this case, the third microarray experiment given by 
         ylim = c(-3.5,3.5),                               #'microarray.raw[,3]') each subsequent parameter is separated by a comma changing 
         main="TITLE_GOES_HERE")                           #the X and Y labels, removing the legend, and giving our plot a title (using the 
                                                           #main = parameter in "").
    
                                                           #Give this plot an appropriate and specific title.
    
    abline(h = 2)                                          #Lastly, we will add a horizontal line at +2 and -2 to show our two-fold change 
    abline(h = -2)                                         #cut-off.
    
###Post-Normalization####
    plot(normalized.array[,3], xvar="maA", yvar="maM",     #We repeat the same process as above but using the 'normalized.array' data for the 
         zvar="maPrintTip",                                #same treatment.
         legend.func = NULL,
         ylim= c(-3.5,3.5),
         main="TITLE_GOES_HERE")                           #Give this plot an appropriate and specific title as well.
    abline(h = 2)
    abline(h = -2)
  
  dev.off()                                                #Once our plots are complete, we can use the dev.off() function to save to the pdf 
                                                           #file we specified above and return r to its default plot output window.

  
  
  
   
#SUMMARIZING EXPRESSION VALUES####
  #In addition to the two plots, we also want to save the processed expression values for each gene.
 
  
   
expression.data<-as.data.frame(normalized.array@           #The first step is to extract just the expression values from the normalized array 
                         maM[49:4200,], na.omit=TRUE)      #VARIABLE. To do that, we simply have to specify what part of the array we want and 
                                                           #save that as the new VARIABLE expression.data as a table of values.
  
  row.names(expression.data)<-normalized.array@            #Unfortunately, the row names and column names are not extracted at the same time,
                        maGnames@maInfo$Name[49:4200]      #so we need to define these both, extracting the gene names from the array and the 
                                                           #column names from the experiment description.
  colnames(expression.data)<-Targets@maInfo$Names
  
  names<-rownames(expression.data)                         #These two lines add a new column at the begging and copy the row names (genes) 
  expression.data<-cbind(names,expression.data)            #into it; this is important for clustering later.
  
write.csv(expression.data[2:5], "FILE_NAME_HERE.csv")      #The last step is to export the expression.data VARIABLE as a CSV file
                                                           #Change the name of the file to be Expression_Values followed by your name, 
                                                           #then .csv





#CLUSTERING####
 

##Filtering and setting a cut-off value####
expression.data.filtered<-filter_at(expression.data,       #The first step in clustering is filtering the data to only include values that 
                                vars(starts_with("g")),    #show a fold change of 2 or greater (two-fold increase or decrease). To filter the 
                                any_vars((abs(.)>2)))      #data, we use the filter_at function. 
                                                           # -First, we indicate which data we want to filter (the expression.data VARIABLE) 
                                                           # -Second, we define what parts of the data we want to filter by, in this case, any
                                                           #  column starting with g, which are our 4 treatments. 
                                                           # -Lastly, we define how we want to filter
                                                           #   -any_vars tells the filter function that we want any row that at least one of  
                                                           #    the treatments meets the filtering criteria 
                                                           #   -abs(.) indicates that the absolute value should be used
                                                           #   - >2 tells the filter function to filter for values greater than 2.


##Clustering Function####
#Clustering takes place 2-dimensionally clustering both by row (gene) and by column (treatment).


hr <- hcluster(expression.data.filtered[2:5],              #We use the hcluster function for both; as usual, we define what data we want to
               method = "ENTER_METHOD_HERE",               #use. Next, we indicate what clustering method we wish to use; in this case, we
               link = "ENTER_LINKAGE_TYPE_HERE")           #want to use Pearson clustering. Lastly, we define what linkage we want to use.
                                                           #For this, we will use average linkage.
                                                          
                                                           #Change the clustering method to "pearson" and linkage to "average" for both the 
                                                           #row clustering and column clustering keeping the capitalization the same.


hc <- hcluster(t(expression.data.filtered[2:5]),           #To cluster columns, we use the same function but need to swap the rows and columns 
               method = "ENTER_METHOD_HERE",               #of the data. Thankfully this is quickly done by adding a 't' in front of the data
               link = "ENTER_LINKAGE_TYPE_HERE")           #we want to use.

                                                           #Change the clustering method to "pearson" and linkage to "average" for both the 
                                                           #row clustering and column clustering keeping the capitalization the same.


##Saving cluster files to use with TreeView####
#TreeView requires 3 files to display the heatmap. A .gtr file contains the information for the row dendrogram; a .atr file contains the 
#information for the column dendrogram, and a .cdt file which contains the clustering and actual heatmap information.

r2gtr(hr,file="gene-expression-clustered.gtr",
          distance=hr$dist.method,dec='.',digits=5)
r2atr(hc,file="gene-expression-clustered.atr",
          distance=hc$dist.method,dec='.',digits=5)
r2cdt(hr,hc,expression.data.filtered,labels=TRUE,
          description=FALSE,dec='.',
          file="gene-expression-clustered.cdt")



