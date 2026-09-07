CLASS lhc_Books DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Books RESULT result.

    METHODS checkOut FOR MODIFY
      IMPORTING keys FOR ACTION Books~checkOut RESULT result.

    METHODS returnBook FOR MODIFY
      IMPORTING keys FOR ACTION Books~returnBook RESULT result.
    METHODS validateBook FOR VALIDATE ON SAVE
      keys FOR Books~validateBook.

ENDCLASS.

CLASS lhc_Books IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF zr_lib_books IN LOCAL MODE
      ENTITY Books
        FIELDS ( is_checkedout )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_books).

    result = VALUE #( FOR book IN lt_books (
      %tky               = book-%tky
      %action-checkOut   = COND #( WHEN book-is_checkedout = abap_true
                                   THEN if_abap_behv=>fc-o-disabled
                                   ELSE if_abap_behv=>fc-o-enabled )
      %action-returnBook = COND #( WHEN book-is_checkedout = abap_true
                                   THEN if_abap_behv=>fc-o-enabled
                                   ELSE if_abap_behv=>fc-o-disabled )
    ) ).
  ENDMETHOD.

  METHOD checkOut.
    DATA: lv_due TYPE d.
    lv_due = cl_abap_context_info=>get_system_date( ) + 14.

    MODIFY ENTITIES OF zr_lib_books IN LOCAL MODE
      ENTITY Books
        UPDATE FIELDS ( is_checkedout due_date )
        WITH VALUE #( FOR key IN keys (
          %tky          = key-%tky
          is_checkedout = abap_true
          due_date      = lv_due
        ) ).

    READ ENTITIES OF zr_lib_books IN LOCAL MODE
      ENTITY Books
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_updated_books).

    result = VALUE #( FOR book IN lt_updated_books (
      %tky   = book-%tky
      %param = book
    ) ).
  ENDMETHOD.

  METHOD returnBook.
    MODIFY ENTITIES OF zr_lib_books IN LOCAL MODE
      ENTITY Books
        UPDATE FIELDS ( is_checkedout due_date )
        WITH VALUE #( FOR key IN keys (
          %tky          = key-%tky
          is_checkedout = abap_false
          due_date      = '00000000'
        ) ).

    READ ENTITIES OF zr_lib_books IN LOCAL MODE
      ENTITY Books
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_returned_books).

    result = VALUE #( FOR book IN lt_returned_books (
      %tky   = book-%tky
      %param = book
    ) ).
  ENDMETHOD.

  METHOD validateBook.
    " Read the relevant fields of instances being saved
    READ ENTITIES OF zr_lib_books IN LOCAL MODE
      ENTITY Books
        FIELDS ( title author due_date is_checkedout )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_books).

    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

    LOOP AT lt_books INTO DATA(ls_book).
      " 1. Validate: Title must not be blank
      IF ls_book-title IS INITIAL.
        APPEND VALUE #( %tky = ls_book-%tky ) TO failed-books.
        APPEND VALUE #( %tky = ls_book-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Title cannot be empty.' )
                        %element-title = if_abap_behv=>mk-on
                      ) TO reported-books.
      ENDIF.

      " 2. Validate: Author must not be blank
      IF ls_book-author IS INITIAL.
        APPEND VALUE #( %tky = ls_book-%tky ) TO failed-books.
        APPEND VALUE #( %tky = ls_book-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Author cannot be empty.' )
                        %element-author = if_abap_behv=>mk-on
                      ) TO reported-books.
      ENDIF.

      " 3. Validate: If checked out, due date cannot be in the past
      IF ls_book-is_checkedout = abap_true
         AND ls_book-due_date IS NOT INITIAL
         AND ls_book-due_date < lv_today.
        APPEND VALUE #( %tky = ls_book-%tky ) TO failed-books.
        APPEND VALUE #( %tky = ls_book-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Due Date cannot be in the past.' )
                        %element-due_date = if_abap_behv=>mk-on
                      ) TO reported-books.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
