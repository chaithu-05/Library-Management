CLASS zcl_lib_fill_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_lib_fill_data IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA it_books TYPE TABLE OF zlib_books.

    " Clear old data first
    DELETE FROM zlib_books.

    " Add four books
    it_books = VALUE #(

      (
        client        = sy-mandt
        book_id       = cl_system_uuid=>create_uuid_x16_static( )
        title         = 'The Alchemist'
        author        = 'Paulo Coelho'
        genre         = 'Fiction'
        is_checkedout = abap_false
        due_date      = '00000000'
      )

      (
        client        = sy-mandt
        book_id       = cl_system_uuid=>create_uuid_x16_static( )
        title         = 'Clean Code'
        author        = 'Robert Martin'
        genre         = 'Programming'
        is_checkedout = abap_false
        due_date      = '00000000'
      )

      (
        client        = sy-mandt
        book_id       = cl_system_uuid=>create_uuid_x16_static( )
        title         = 'Harry Potter'
        author        = 'J.K. Rowling'
        genre         = 'Fantasy'
        is_checkedout = abap_true
        due_date      = '20260915'
      )

      (
        client        = sy-mandt
        book_id       = cl_system_uuid=>create_uuid_x16_static( )
        title         = 'Atomic Habits'
        author        = 'James Clear'
        genre         = 'Self Help'
        is_checkedout = abap_false
        due_date      = '00000000'
      )

    ).

    " Insert books into database
    INSERT zlib_books FROM TABLE @it_books.

    " Display success message
    out->write(
      'Success! Four books have been added to the library.'
    ).

  ENDMETHOD.

ENDCLASS.
