import React from 'react';
import { shallow, mount, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import BookCountTable from 'components/book_count_table';
import { findColumn } from './book_share_helper.js';

configure({ adapter: new Adapter() });

describe('BookCountTable', () => {
  const counts = [
    [{title: 'Test 1', key: '1'}, 3],
    [{title: 'Test 2', key: '2', short_name: 'T2'}, -2]
    ];

  const findTable = function (caption) {
    const wrapper = shallow(<BookCountTable counts={counts} caption={caption}/>);
    return wrapper.find("BookShareTable").first();
  };

  it('should copy counts to the table data', () => {
    const table = findTable("Data Test")
    expect(table.prop('data')).toEqual(counts);
  });

  it('should specify "0" as the book property', () => {
    const table = findTable("Book Test")
    expect(table.prop('book')).toEqual('0');
  });

  it('should contain an author column', () => {
    const columns = findTable("Description Test").prop('columns');
    const column = findColumn(columns, "book.author");
    expect(column).toHaveProperty("classes", 'author');
  });

  it('should contain a description column', () => {
    const columns = findTable("Description Test").prop('columns');
    const column = findColumn(columns, "book");
    expect(column).toHaveProperty("formatter");
    expect(column).toHaveProperty("classes", 'description');
  });

  it('should contain a needs column', () => {
    const columns = findTable("Description Test").prop('columns');
    const column = findColumn(columns, "1");
    expect(column).toHaveProperty("classes", 'need');
  });
});

