@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Library Books Root View'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZR_LIB_BOOKS
  as select from zlib_books
{
  key book_id,
      title,
      author,
      genre,
      is_checkedout,
      due_date
}
