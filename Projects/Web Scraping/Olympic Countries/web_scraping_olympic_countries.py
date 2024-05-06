import requests
from bs4 import BeautifulSoup
import pandas as pd
from sqlalchemy import create_engine

base_url = "https://olympics.com/ioc/national-olympic-committees"
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; rv:125.0) Gecko/20100101 Firefox/125.0"
}

response = requests.get(url=base_url, headers=headers)

if response.status_code == 200:
    soup = BeautifulSoup(response.content, "html.parser")

    # Getting relevant information from the webpage
    countries = soup.find_all(
        "span", attrs={"class": "sc-bdnyFh bEHmZC sc-jMRbbT ipHRlt text--body"}
    )
    images = soup.find_all(
        "picture", attrs={"data-cy": "picture-wrapper", "class": "sc-lmgPJu dajqDo"}
    )

    # Initializing lists for dataframe
    countries_list = []
    links_list = []
    images_list = []
    years_list = []

    # Populating countries_list and links_list
    for index, element in enumerate(countries):
        country = element.text
        link = "https://olympics.com" + element.a.get("href")
        countries_list.append(country)
        links_list.append(link)

    # Populating images_list
    for index, element in enumerate(images):
        image = element.img.get("src")
        images_list.append(image)

    # Visiting the webpage for each country's NOC
    for index, element in enumerate(links_list):
        print(f"Visiting webpage: {element}")
        link_url = element
        link_response = requests.get(url=link_url, headers=headers)

        if link_response.status_code == 200:
            print(f"Getting recognition year at index = {index}")
            link_soup = BeautifulSoup(link_response.content, "html.parser")

            # Getting the recognition year for each country
            country_data = link_soup.find_all(
                "section",
                attrs={"class": "sc-hBMVwJ gpJMpU", "data-cy": "text-block-container"},
            )
            years_list.append(country_data[-1].p.text)
        else:
            years_list.append(None)

else:
    print("Unable to connect")

# Generating a pandas dataframe with the scraped data
print("Generating DataFrame...")
df = pd.DataFrame(
    {
        "country_name": countries_list,
        "recognition_year": years_list,
        "noc_webpage": links_list,
        "noc_image": images_list,
    }
)

# Defining postgresql database information
db_name = "olympic_countries"
table_name = "country_table"

# Create sqlalchemy engine
engine = create_engine(f"postgresql://postgres:admin@localhost/{db_name}")
connect = engine.connect()

# Load data into postgresql table
df.to_sql(table_name, con=connect, if_exists="replace", index=False)
print(
    f"{df.shape[0]} rows and {df.shape[1]} columns from dataframe exported to postgresql"
)
