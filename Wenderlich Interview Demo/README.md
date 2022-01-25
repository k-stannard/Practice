# Notes

## Practiced Concepts

- MVVM implementation
- Network API calls
- Data model structuring for JSON
- Populating the view model for a table view

### Challenges

1. MVVM seemed a bit confusing at first with all of the components required to set it up, but once I was able to see the overall structure and how all the pieces fit together it makes a lot more sense. This method seems a lot easier to populate table view data, even if it takes a bit more time to setup.
2. Another challenge was creating a data model for the api call. The nested JSON data tripped me up on more than one occasion, but I think it's finally clicking. If the outer most bracket is a curly brace, then it's a dictionary, otherwise it's an array and `[]` are needed when writing the property type. IE: `let data: [ArticleData]`. If it's a dictionary all you need to do is write `let attributes: Article`.
3. Populating the view model with nested data was tricky as well. I ended up having to unwrap the properties in the network call to get down to the array level of the data, but I wasn't sure how to keep going further into the nested api. I ended up looping over the returned result and appending the contents into the array, and then appending the array to the view model with another method. I need to look to see if there is a better way to go about handling those cases.
