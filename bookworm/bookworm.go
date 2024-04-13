package bookworm
// A Bookworm contains the list of books on a bookworm's shelf.
type Bookworm struct {
    Name  string `json:"name"`
    Books []Book `json:"books"`
}
 
// Book describes a book on a bookworm's shelf.
type Book struct {
    Author  string `json:"author"`
    Title   string `json:"title"`
}

var bookworms []Bookworm
 
// Decode the file and store the content in the value bookworms.
err = json.NewDecoder(f).
Decode(&bookworms)
if err != nil {
    return nil, err
}
// loadBookworms reads the file and returns the list of bookworms, and their beloved books, found therein.
func loadBookworms(filePath string) ([]Bookworm, error) {
    f, err := os.Open(filePath)
    if err != nil {
        return nil, err
    }
    defer f.Close()
 
    // Initialise the type in which the file will be decoded.
    var bookworms []Bookworm
 
    // Decode the file and store the content in the variable bookworms.
    err = json.NewDecoder(f).Decode(&bookworms)
    if err != nil {
        return nil, err
    }
 
    return bookworms, nil
}
