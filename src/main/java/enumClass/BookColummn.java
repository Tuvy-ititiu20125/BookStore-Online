package enumClass;

public enum BookColummn {
    ID("ID"),
    BOOK_TITLE("BookTitle"),
    AUTHOR_NAME("AuthorName"),
    PRICE("Price"),
    TYPE("Type");

    private final String columnName;

    private BookColummn(String columnName) {
        this.columnName = columnName;
    }

    public String toString() {
        return columnName;
    }
}