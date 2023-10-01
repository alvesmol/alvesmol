import urllib.request as urllib
import pandas as pd
from bs4 import BeautifulSoup
import matplotlib.pyplot as plt

# def scrape(URL):

#     request = urllib.Request(URL, headers = {'User-Agent':'Mozilla/5.0'})
#     page = urllib.urlopen(request)
#     soup = BeautifulSoup(page, features="lxml")
#     colums = soup.find('div', class_= 'column')
#     all_articles = colums.find_all('article')
#     access_page = soup.find('ol',class_ = 'wp-paginate font-inherit')

#     next_links = soup.find('div', class_ = 'nav-previous') 
#     next_page = next_links.find('a')
#     if next_page is None: 
#         print('dope')

#     # end_cycle_link = soup.find('div', class_= 'nav-next')
#     # done_link = end_cycle_link.find('a')['href']
    
#     # if done_link == 'https://www.consortiuminfo.org/list/page/117/':
#     #     print(done_link)

#     # if next_links is None: 
#     #     print('papa')

#     # p = next_link[len(next_link)-1]
#     # d =  p.find('a')['class']

#     # if not next_links: 
#     #     print('the man')
#     # print(next_page)
    

#     # Iterate over the titles and extract information from the linked pages
#     listOfSubContent = []
#     for article in all_articles:
#             link = article.find('a')['href']  # Get the link from the 'href' attribute
#             linked_page = urllib.urlopen(link)  # Open the linked page
#             linked_soup = BeautifulSoup(linked_page, features="lxml")
#             # Extract the desired information from the linked page
#             # Example:
#             list_content = linked_soup.find('div',class_='split') # now is time to concatenate all of them together
#             page_content = list_content.find('div', id='post-meta').text.split('\n')
#             technicalAreacon = list_content.find_all('li')
#             # print(page_content)
#             # print(technicalAreacon)
            
#             tech_content_list = []
#             listOfList_content = []
#             for i in technicalAreacon :
#                 tech_content_list.append(i.text)
#             listOfList_content.append(tech_content_list)
            
#             # full_clean_content = page_content + listOfList_content

#             # print(full_clean_content)
#             # Perform further processing on the extracted content as needed'
#             # Remove empty elements from the list
#             # content = list(filter(None, content))



#             content_list = []
#             for item in page_content:
#                 if len(item) >= 2:
#                     eliminate_t = item.replace('\t', '')
#                     content_list.append(eliminate_t)
            
#             # print(content_list)
#             full_clean_content = content_list + ['Technical Areas'] + listOfList_content
#             if is_even(len(full_clean_content)):
#              listOfSubContent.append(full_clean_content)
#     # print(full_clean_content)



#     # print(listOfSubContent)
#     CleanDict(listOfSubContent)    


#return list of list of each article
def third_scrape(URL):

    ListOfListOFAllArticles = []
    page_num = 1  # Start with the first page
    while True:
        request = urllib.Request(URL , headers={'User-Agent': 'Mozilla/5.0'})
        page = urllib.urlopen(request)
        soup = BeautifulSoup(page, features="lxml")
        columns = soup.find('div', class_='column')
        # columns = soup.find('div',class_="split")
        all_articles = columns.find_all('article')


        # allows the links to be incremented by one if the last li contains class next. 
        pages_class = soup.find('div', class_='navigation')
        access_page = pages_class.find('ol', class_='wp-paginate font-inherit')
        next_links = access_page.find_all('li')
        next_page = next_links[-1]

        # print(next_page)

        # Process the data from the current page
        listOfSubContent = []
        for article in all_articles:
            link = article.find('a')['href']
            linked_page = urllib.urlopen(link)
            linked_soup = BeautifulSoup(linked_page, features="lxml")

            # Extract the desired information from the linked page
            # Example:
            list_content = linked_soup.find('div',class_='split') # now is time to concatenate all of them together
            page_content = list_content.find('div', id='post-meta').text.split('\n')
            technicalAreacon = list_content.find_all('li')
            
            tech_content_list = []
            listOfList_content = []
            for i in technicalAreacon :
                tech_content_list.append(i.text)
            listOfList_content.append(tech_content_list)
            
            #clean the data 
            content_list = []
            for item in page_content:
                if len(item) >= 2:
                    eliminate_t = item.replace('\t', '')
                    content_list.append(eliminate_t)
            
            # print(content_list)
            if len(tech_content_list) != 0:
               full_clean_content = content_list + ['Technical Areas'] + listOfList_content
               if is_even(len(full_clean_content)):
                    listOfSubContent.append(full_clean_content)

              
        ListOfListOFAllArticles.append(listOfSubContent)
        #stops change of pages when previous information is not found on the website 
        linkEndCycle = soup.find('div', class_ = 'nav-previous') 
        cycleEnded = linkEndCycle.find('a')

        if cycleEnded is None: 
            # print(listOfSubContent )
            # return listOfSubContent    
            break
    
        #transition to the next page 
        next_link = next_page.find('a')['class']
        if next_link == ['next']:
            page_num += 1
            # print(next_link)

        
        # Generate the URL for the next page
        # next_page_url = next_page.find('a')['href']
        URL = f'https://www.consortiuminfo.org/list/page/{page_num}/'
        # print(f'These are the numbers of pages: {page_num}')
        
    # print(ListOfListOFAllArticles[0])
    # return DictOfAllArticle
    create_csv_file(ListOfListOFAllArticles)



def clean_file(file): 

    KeyList = []
    ValueList = []

    for i in file: 
        if is_even(file.index(i)): 
            KeyList.append(i)

        else: 
            
            ValueList.append(i)

    # print(KeyList)
    return KeyList, ValueList

#create a dictionary using the list of each article information
def GatherIntoDic( DictOfAllArticle): 

    #the mistake is that you are using list of articles instead of the list inside the article 
    ListOfDict = []
    for listOfSubContent in DictOfAllArticle:
        for list in listOfSubContent:
            
                key_list, value_list = clean_file(list)
                d = {}
        
                for colum_name in range(len(key_list)): 
                    d[key_list[colum_name]] = []
                    d[key_list[colum_name]].append(value_list[colum_name])  
        
                ListOfDict.append(d)

    print(len(ListOfDict))
    # print(ListOfDict)

    return ListOfDict  


def is_even(index):

    if (index % 2) == 0: 
        return True 

    return False

#clean the file, by place in a list and keep only the repeated title
def CleanDict(DictOfAllArticle): 
    # unclean_file = GatherIntoDic(DictOfAllArticle)

    # new_dict = {}
    # keys = ['Title', 'Date', 'Status', 'Abstract', 'Specifications', 'IPR', 'Link', 'Technical Areas']

    # for dictionary in unclean_file:
    #     for key in keys:
    #         if key in dictionary:
    #             if key in new_dict:
    #                 new_dict[key].extend(dictionary[key])
    #             else:
    #                 new_dict[key] = dictionary[key]

    
    # # print(unclean_file)

    # return new_dict 


    unclean_file = GatherIntoDic(DictOfAllArticle)

    new_dict = {}
    keys = ['Title', 'Date', 'Status', 'Abstract', 'Specifications', 'IPR', 'Link', 'Technical Areas']

    max_length = max(len(dictionary.get(key, [])) for dictionary in unclean_file for key in keys)

    for dictionary in unclean_file:
        for key in keys:
            values = dictionary.get(key, [])
            new_dict.setdefault(key, []).extend(values + [None] * (max_length - len(values)))

    print(len(new_dict))
    return new_dict




def create_csv_file(DictOfAllArticle): 
    file = CleanDict(DictOfAllArticle)
    # print(file)

    df = pd.DataFrame(file)

    df.to_csv('file.csv', index = False)


    # dataframe = pd.DataFrame(file)
    # dataframe.to_csv("Archive.csv",index = False)
    # df = pd.read_csv("Archive.csv", parse_dates= ["Date Joined"], index_col = False)

    # file = p_file
    # print(len(file))
    # key_to_convert = 'Technical Areas'
    # if key_to_convert in file and isinstance(file[key_to_convert], list) and len(file[key_to_convert]) == 1:
    #     file[key_to_convert] = file[key_to_convert][0]

    #     print(file)

    #     print('im going to b him')
    
    # r download csv from url
# gives additional functions to handle secure https


def convert_csv_to_excel(csv_file, excel_file, sheet_name='Sheet1'):
    try:
        # Read the CSV file into a DataFrame
        df = pd.read_csv(csv_file)

        # Save the DataFrame to an Excel file
        df.to_excel(excel_file, sheet_name=sheet_name, index=False)

        return f"CSV file '{csv_file}' successfully converted to Excel file '{excel_file}'."

    except Exception as e:
        return f"An error occurred: {str(e)}"
    
    
    
def clean_column(excel_file, sheet_name, column_name):
    try:
        # Load the Excel file into a DataFrame
        df = pd.read_excel(excel_file, sheet_name=sheet_name)

        # Replace '[', ']', and "'" with an empty space in the specified column for each row
        df[column_name] = df[column_name].replace(r"[\[\]']", "", regex=True)

        # Save the modified DataFrame back to the Excel sheet
        df.to_excel(excel_file, sheet_name=sheet_name, index=False)

        return f"Column '{column_name}' in the sheet '{sheet_name}' cleaned successfully."

    except Exception as e:
        return f"An error occurred: {str(e)}"


    
def distribute_names_to_columns(excel_file, sheet_name, column_name):
    try:
        # Load the Excel file into a DataFrame
        df = pd.read_excel(excel_file, sheet_name=sheet_name)

        # Get the set of unique names from all rows
        unique_names = set()
        for value in df[column_name]:
            if isinstance(value, str):
                unique_names.update(name.strip() for name in value.split(","))

        # Create columns for each unique name
        for name in unique_names:
            df[name] = ''

        # Distribute the data to the corresponding columns
        for index, row in df.iterrows():
            if isinstance(row[column_name], str):
                names = set(name.strip() for name in row[column_name].split(","))
                for name in names:
                    df.at[index, name] = 'Found'

        # Drop the original column as we've distributed the data to new columns
        df.drop(column_name, axis=1, inplace=True)

        # Save the modified DataFrame back to the Excel sheet
        df.to_excel(excel_file, sheet_name=sheet_name, index=False)

        return "Names distributed to the columns successfully."

    except Exception as e:
        return f"An error occurred: {str(e)}"


if __name__=='__main__':

    # URL = 'https://www.consortiuminfo.org/list/'
    # # # URL = 'https://www.consortiuminfo.org/list/page/118/'
    # # # scrape(URL)
    # third_scrape(URL)
    
    csv_file_path = 'file.csv'
    excel_file = 'Final Standards Setting Organizations List Complete 08 04 2023 .xlsx'
    # result = convert_csv_to_excel(csv_file_path, excel_file)
    # print(result)
    
    #buh sta deixan preco na bu labios 
    
    # excel_file = 'Archive Standardize file 08 03 2023 .xlsx'
    sheet_name = 'Sheet1'
    column_name = 'Technical Areas'
    # name_list = ['Open Source Initiatives','Significant Open Source Foundations','De Jure Standards Development Organizations', 'National','Industry Categories',
    #         'Aeronautics and Aerospace','Automotive', 'BioIT and Life Sciences', 'Clean Tech & Renewable Energy', 'Construction and Facilities Management',
    #         'Consumer Electronics and Content', 'Defense', 'Digital and Distance Learning', 'Electronics', 'Emergency Response',
    #         'Financial Services', 'Health and Medical','Home Network', 'Manufacturing', 'Multi-Industry', 'Natural and Environmental Sciences', 'Power and SmartGrid',
    #         'Real Estate', 'Sustainability', 'Efficiency and Green Initiatives', 'Telecom', 'e-Commerce','Other Categories', 'Advocacy/Lobbying',
    #         'Business Models and Collaboration', 'Categories of One', 'Educational Associations', 'Other Consortium Index Sites', 'Promotional & Trade Associations', 
    #         'Africa', 'Americas', 'Asia', 'Australia/Oceania', 'Europe', 'Architecture and Infrastructure', 'Artificial Intelligence', 'Audio/Video/Multimedia', 'Blockchain', 'Cloud Computing and Data', 'Credit/Debit/Smartcard', 'Electronic Media', 
    #         'Grid Computing', 'Hardware', 'Imaging', 'Information and Communication Technology', 'Internet', 'Internet of Things', 
    #         'Interoperability', 'Languages/Protocols', 'Network', 'Security & Cybersecurity', 'Semiconductors', 'Software', 'Wireless and Mobile']
    
    # result = clean_column(excel_file, sheet_name, column_name)
    # result = distribute_names_to_columns(excel_file_path, sheet_name, column_name, name_list)
    result = distribute_names_to_columns(excel_file, sheet_name, column_name)
    print(result)



    
    

    # file = {'M' : [['Hardware', 'Open Source Initiatives', 'Technical Categories']], 'areas' :['Business Models and Collaboration', 'Cloud Computing and Data', 'Internet of Things'], 'LuisM' :[['Interoperability', 'Languages/Protocols', 'Network', 'Technical Categories']]}

    # key_to_convert = 'LuisM'
    # if key_to_convert in file and isinstance(file[key_to_convert], list) and len(file[key_to_convert]) == 1:
    #     file[key_to_convert] = file[key_to_convert][0]

    #     print(file)



    # num = 0
    # DictOfAllArticle = third_scrape(URL)
    # num = 0
    # for listOfSubContent in DictOfAllArticle:
    #     for list in listOfSubContent:
          
    #          key_list, value_list = clean_file(list)
    #          if len(key_list) == len(value_list):
    #                 num+=1
    #                 for n in range(len(list) - 1, -1, -1):
    #                     if list[n] == 'Abstract':
    #                         list[n + 1] = list[n + 1] + '. ' + list[n + 2]
    #                         del list[n + 2]  # Delete the other n + 2 element

                

    #             # print(f' This is number of keylist ===== {len(key_list)}')
    #             # print('\n')
    #             # print('===================================================================>')
    #             # print(f' this is number of valuelist ===== {len(value_list)}')
    #             # print('\n')
    #                 print(list)
    #                 print('\n')


    # print(num)


#     names = [ 'Rosilda','luis', 'Fatinha', 'chindin','vovo']
#     for n in range(len(names) - 1, -1, -1):
#         if names[n] == 'luis':
#             names[n + 1] = names[n + 1] + ', ' + names[n + 2]
#             del names[n + 2]  # Delete the other n + 2 element

# print(names)





    # third_scrape(URL)
      

    # print(p[0])
    # count_name = ['Luis', 'Ronaldo', 'Monteiro', 'Carlos', 'Lopes', 'Rosiana', 'Tio', 'Tia', 'Vovo', 'dono','technical area', ['cuma, cumpa, sogra']]
    # group_name = ['Willian','James','Osmar','Alex', 'Xander', 'technical area', ['dope','rich','poor']]

    # them_together = count_name + group_name

    # print(count_name[2])



    # clean_file()
    # runItup()

    # plceItIntoCsvFile(URL)
    # print out as it is full list of the informations, add all the odd indexes into a l
    # ist, and create a list of even index convert it into a key 
    # ['Title', 'Date', 'Status', 'Abstract', 'Specifications', 'IPR', 'Link', 'Technical Areas']
    #create a list of dict and put all the values into the same list of which have the same keys 

    



