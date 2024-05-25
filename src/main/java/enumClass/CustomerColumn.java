package enumClass;

public enum CustomerColumn {
    ID("ID"),
    FIRSTNAME("FirstName"),
    LASTNAME("LastName");

    private final String columnName;

    private CustomerColumn(String columnName) {
        this.columnName = columnName;
    }

    public String toString() {
        return columnName;
    }
}