@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Library Books Projection'
@UI: {
  headerInfo: {
    typeName: 'Book',
    typeNamePlural: 'Books',
    title: { type: #STANDARD, value: 'title' },
    description: { value: 'author' }
  },
  presentationVariant: [{
    sortOrder: [{ by: 'title', direction: #ASC }],
    visualizations: [{ type: #AS_LINEITEM }]
  }]
}
define root view entity ZC_LIB_BOOKS
  provider contract transactional_query
  as projection on ZR_LIB_BOOKS
{
  @UI.facet: [
    {
      id: 'BookDetails',
      purpose: #STANDARD,
      type: #IDENTIFICATION_REFERENCE,
      label: 'Book Details',
      position: 10
    }
  ]

  @UI.hidden: true
  key book_id,

  @EndUserText.label: 'Title'
  @UI.lineItem: [
    { position: 10, cssDefault.width: '25%' },
    { type: #FOR_ACTION, dataAction: 'checkOut', label: 'Check Out' },
    { type: #FOR_ACTION, dataAction: 'returnBook', label: 'Return Book' }
  ]
  @UI.identification: [{ position: 10 }]
  title,

  @EndUserText.label: 'Author'
  @UI.lineItem: [{ position: 20, cssDefault.width: '20%' }]
  @UI.identification: [{ position: 20 }]
  author,

  @EndUserText.label: 'Genre'
  @UI.lineItem: [{ position: 30, cssDefault.width: '20%' }]
  @UI.identification: [{ position: 30 }]
  genre,

  @EndUserText.label: 'Checked Out'
  @UI.lineItem: [{ position: 40, cssDefault.width: '15%' }]
  @UI.identification: [{ position: 40 }]
  is_checkedout,

  @EndUserText.label: 'Due Date'
  @UI.lineItem: [{ position: 50, cssDefault.width: '20%' }]
  @UI.identification: [{ position: 50 }]
  due_date
}
