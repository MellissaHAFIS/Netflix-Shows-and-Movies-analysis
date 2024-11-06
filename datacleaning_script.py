import pandas as pd
import numpy as np
import ast
from sklearn.impute import KNNImputer
import ast


titles_df = pd.read_csv('./datasets/titles.csv')
credits_df = pd.read_csv('./datasets/credits.csv')


titles_df.fillna({'description':'No discription is available'}, inplace=True)

titles_df.fillna({'title':'Missing title'}, inplace=True)


titles_df['age_certification'] = titles_df.groupby('release_year')['age_certification'].transform(lambda x: x.fillna(x.mode().iloc[0] if not x.mode().empty else "Unknown"))


titles_df['seasons']=np.where(
    (titles_df['seasons'].isna()) & (titles_df['type']=='MOVIE'), 
    0, 
    titles_df['seasons']
)

titles_df.isnull().sum()['seasons']

# Find the indices where values are missing
missing_indices = titles_df['imdb_id'].isna()

# Generate unique values starting from the maximum value in the column + 1

existing_ids=titles_df['imdb_id'].dropna()
max_id=max( (int(id[2:])) for id in existing_ids) 

# Generate unique IDs for missing values
new_ids = [f'tt{max_id + i + 1}' for i in range(missing_indices.sum())]

# Fill missing IDs with unique values
titles_df.loc[missing_indices, 'imdb_id'] = new_ids


imputer = KNNImputer(n_neighbors=3)
titles_df[['imdb_score', 'imdb_votes', 'tmdb_popularity', 'tmdb_score']] = imputer.fit_transform(titles_df[['imdb_score', 'imdb_votes', 'tmdb_popularity', 'tmdb_score']])



credits_df.fillna({'character':'character unknown'}, inplace=True)


credits_df.drop_duplicates('person_id',inplace=True)

titles_df['release_year'] = pd.to_numeric(titles_df['release_year'], errors='coerce').astype(int)
titles_df['runtime'] = pd.to_numeric(titles_df['runtime'], errors='coerce').astype(int)
titles_df['seasons'] = pd.to_numeric(titles_df['seasons'], errors='coerce').astype(int)
titles_df['imdb_score'] = titles_df['imdb_score'].astype(float)
titles_df['tmdb_score'] = titles_df['tmdb_score'].astype(float)
titles_df['imdb_votes'] = titles_df['imdb_votes'].astype(float)
titles_df['tmdb_popularity'] = titles_df['tmdb_popularity'].astype(float)

titles_df['genres']=titles_df['genres'].apply(ast.literal_eval)
all_genres = titles_df['genres'].explode() #we extract all the genres 
all_genres.unique() #we keep unique values of genres 

unique_genres = pd.DataFrame(all_genres.dropna().unique(), columns=['genre_name'])

# Save to CSV
unique_genres.to_csv('./datasets/genres.csv', index=False)
titles_df['production_countries']=titles_df['production_countries'].apply(ast.literal_eval)
all_countries = titles_df['production_countries'].explode() #we extract all the countries
all_countries.unique() #we keep unique values of countries
unique_countries = pd.DataFrame(all_countries.dropna().unique(), columns=['country'])
# Save to CSV
unique_countries.to_csv('./datasets/countries.csv', index=False)

TitleProdCountry = pd.DataFrame(columns=['title_id', 'prodCountry'])
#Iterate through titles_df to populate TitleHasGenre
for index, row in titles_df.iterrows():
    # Get the list of genres directly
    prodCountries = row['production_countries']
    
    # Create a DataFrame for this title with one row per genre
    title_countries = pd.DataFrame({
        'title_id': [row['id']] * len(prodCountries),
        'prodCountry': prodCountries
    })
    
    # Append to TitleHasGenre DataFrame
    TitleProdCountry = pd.concat([TitleProdCountry, title_countries], ignore_index=True)

TitleProdCountry.to_csv('./datasets/titleProdCountry.csv', index=False)

TitleHasGenre = pd.DataFrame(columns=['title_id', 'genre'])
#Iterate through titles_df to populate TitleHasGenre
for index, row in titles_df.iterrows():
    # Get the list of genres directly
    genres = row['genres']
    
    # Create a DataFrame for this title with one row per genre
    title_genres = pd.DataFrame({
        'title_id': [row['id']] * len(genres),
        'genre': genres
    })
    
    # Append to TitleHasGenre DataFrame
    TitleHasGenre = pd.concat([TitleHasGenre, title_genres], ignore_index=True)

TitleHasGenre.to_csv('./datasets/titleHasGenre.csv', index=False)

titles_df = titles_df.drop(columns=['genres', 'production_countries'], errors='ignore')

# Save cleaned data to new CSV files
titles_df.to_csv('./datasets/cleaned_titles.csv', index=False)
credits_df.to_csv('./datasets/cleaned_credits.csv', index=False)


