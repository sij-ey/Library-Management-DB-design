-- Categories Table
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL UNIQUE
);

-- Publishers Table
CREATE TABLE Publishers (
    PublisherID INT AUTO_INCREMENT PRIMARY KEY,
    PublisherName VARCHAR(150) NOT NULL UNIQUE,
    Address VARCHAR(255)
);

-- Authors Table
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL
);

-- Books Table
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    CategoryID INT NOT NULL,
    PublisherID INT NOT NULL,
    PublishedYear YEAR,
    CopiesAvailable INT DEFAULT 1 CHECK (CopiesAvailable >= 0),
    CONSTRAINT fk_Category FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    CONSTRAINT fk_Publisher FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);

-- Junction Table for Many-to-Many Book-Authors
CREATE TABLE BookAuthors (
    BookID INT NOT NULL,
    AuthorID INT NOT NULL,
    PRIMARY KEY (BookID, AuthorID),
    CONSTRAINT fk_Book FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    CONSTRAINT fk_Author FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE
);

-- Members Table
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    MembershipDate DATE NOT NULL DEFAULT CURDATE()
);

-- Loans Table
CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT NOT NULL,
    MemberID INT NOT NULL,
    LoanDate DATE NOT NULL DEFAULT CURDATE(),
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    CONSTRAINT fk_LoanBook FOREIGN KEY (BookID) REFERENCES Books(BookID),
    CONSTRAINT fk_LoanMember FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);
