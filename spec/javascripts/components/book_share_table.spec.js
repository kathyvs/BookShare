import React from 'react';
import { shallow, mount, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import BookShareTable from 'components/book_share_table';
import { findColumn } from './book_share_helper.js';

configure({ adapter: new Adapter() });


describe('BookShareTable', () => {

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

  const defaultColumns = [
    {dataField: 'book.title',
     text: 'Title'
    },
    {dataField: 'book.type',
     text: 'Book Type',
     custom: 'Custom value'
    },
    {dataField: 'value',
     text: 'Simple Value',
     align: 'right'
    },
    {dataField: 'squaredValue',
     text: 'Squared Value',
     align: 'right',
     extractBy: (obj) => obj.value * obj.value
    }
  ];

  const shallowTable = function (caption, book = 'book_name') {
    const wrapper = shallow(<BookShareTable data={data} book={book} caption={caption} columns={defaultColumns}/>);
    return wrapper.find("BootstrapTableContainer").first();
  };

  /*
   * Book properties
   */

  it('should always have "book.key" as the key field', () => {
    const table = shallowTable("Key Test");
    expect(table.prop('keyField')).toEqual('book.key');
  });

  it('should retrieve the books from the book property when it is a string', () => {
    const table = shallowTable("Book Test");
    const tableData = table.prop('data');
    for (var i = 0; i < data.length; i++) {
      expect(tableData[i].book).toEqual(data[i].book_name);
    }
  });

  it('should copy the column data minus extractBy property', () => {
    const table = shallowTable("Column Test");
    const columns = table.prop('columns');
    defaultColumns.forEach((inputColumn) => {
      const foundColumn = findColumn(columns, inputColumn.dataField);
      const expectedColumn = Object.assign({}, inputColumn);
      delete expectedColumn['extractBy'];
      expect(foundColumn).toEqual(expect.objectContaining(expectedColumn));
    });
  });

  it('should convert data to the table data', () => {
    const table = shallowTable("Data Test");
    const convertedData = table.prop('data');
    for (var i = 0; i < data.length; i++) {
      expect(convertedData[i].value).toEqual(data[i].value);
      expect(convertedData[i].squaredValue).toEqual(data[i].value * data[i].value);
    }
  });

  it('should guarantee that the headers set scope', () => {
    const table = shallowTable("Scope Test");
    const columns = table.prop('columns');
    columns.forEach((column) => {
      if (!column.hidden) {
        expect(column.headerAttrs.scope).toEqual('col');
      }
    });
  });

  it('should copy the caption', () => {
    const table = shallowTable("Caption Test");
    console.log(table.debug());
    expect(table.prop('caption')).toEqual("Caption Test");
  });
});
