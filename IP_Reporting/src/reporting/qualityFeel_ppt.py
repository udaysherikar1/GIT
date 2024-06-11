
a="start ppt"
print("this is a--",a)

import ppt_utils,os

def createQualityFeelPPT():
    
    #read temp text from user home directory.
    user_home = os.path.expanduser("~")
    tempTxtFile = os.path.join(user_home, "reportAutomation.txt")
    with open(tempTxtFile, 'r') as file1:
        outputDir = file1.read()
    
    csvPath = os.path.normpath(os.path.join(outputDir.strip(), "reportAutomationImages.csv"))
    csv_data=ppt_utils.read_csv(csvPath)
    #print("csv_data -->", csv_data)
    i = 1
    n_winCount = 1
    for row in csv_data:
        if i == 1:
            slideTitle = row[1]
            i=i+1
            continue
        if i == 2:
            ppt_template = row[1]
            i=i+1
            continue

        image_path = row[0]
        win_name = row[1]
        l_inch = float(row[2])
        t_inch = float(row[3])
        w_inch = float(row[4])
        h_inch = float(row[5])
        n_newSlideFlag = float(row[6])

        if n_newSlideFlag == 1:
            #add slide 
            slide = ppt_utils.AddSlide(ppt_template,slideTitle)

            #add texts
            textInfo = "Project Title"
            ppt_utils.Add_text(ppt_template,textInfo,0.5,0.1,5.0,0.8,40)

            # add table in ppt_template
            ppt_utils.AddTable(ppt_template,2,5,12.5,0.5,4,1)

        #add image
        ppt_utils.AddImagesInLastSlide(ppt_template,image_path,l_inch,t_inch,w_inch,h_inch)
        #add text box
        if n_winCount % 2 == 1:
            ppt_utils.Add_text(ppt_template,win_name,3.5,1.5,5.0,0.8,30)
            
        if n_winCount % 2 == 0:
            ppt_utils.Add_text(ppt_template,win_name,11.5,1.5,5.0,0.8,30)
                                   
        n_winCount=n_winCount+1    
        

createQualityFeelPPT()
