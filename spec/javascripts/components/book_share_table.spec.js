import React from 'react';
import { shallow, mount, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import BookShareTable from 'components/book_share_table';

configure({ adapter: new Adapter() });


describe('BookShareTable', () => {

  function findColumn(columnList, dataFieldName) {
    const result = columnList.filter((column) => column.dataField == dataFieldName);
    if (result.length !== 1) {
      console.log(result);
      expect(result.length).toBe(1);
    }
    return result[0];
  };

  const data = [{
      book_name: {
        'author': "Author 1",
        'short_name': null,
        'title': 'Test Book',
        'type': 'test',
        'volume': null,
        'key': '111'},
      value: 3},
    ];

  const shallowTable = function (caption, book = 'book_name') {
    const wrapper = shallow(<BookShareTable data={data} book={book} caption={caption}/>);
    return wrapper.find("BootstrapTableContainer").first();
  };

  /*
   * Book properties
   */

  it('should always have "bookId" as the key field', () => {
    const table = shallowTable("Key Test");
    console.log(table.debug());
    expect(table.prop('keyField')).toEqual('book.key');
  });

  it('should have a hidden column pointing to book.key', () => {
    const table = shallowTable("Key Column Test");
    const bookColumn = findColumn(table.prop('columns'), 'book.key');
    expect(bookColumn.hidden).toBeTruthy();
  });

  it('should retrieve the books from the book property when it is a string', () => {
    const table = shallowTable("Book Test");
    const tableData = table.prop('data');
    for (var i = 0; i < data.length; i++) {
      expect(tableData[i].book).toEqual(data[i].book_name);
    }
  });

  // it('should convert data to the table data', () => {
  //   const wrapper = shallow(<BookShareTable data={data} caption="Data Test"/>);
  //   const table = wrapper.find("BootstrapTableContainer").first();
  //   console.log(table.debug());

  //   expect(table.prop('data')).to.equal(data);
  // });
});
