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

  const findTable = function (event_name, editable = false, caption = null) {
    const wrapper = shallow(<BookCountTable counts={counts} form_name={"fname"} editable={editable} event_name={event_name} caption={caption}/>);
    return wrapper.find("BookShareTable").first();
  };

  it('should copy counts to the table data', () => {
    const table = findTable("Data Test")
    expect(table.prop('data')).toEqual(counts);
  });

  it('should be the caption for the event_name', () => {
    const table = findTable("Caption Test")
    expect(table.prop('caption')).toEqual(expect.stringContaining("Caption Test"));
    expect(table.prop('caption')).toEqual(expect.stringContaining("Books for"));
  });

  it('should be the caption for "New Event" if event name is not set', () => {
    const table = findTable("")
    expect(table.prop('caption')).toEqual(expect.stringContaining("New Event"));
  });

  it('should be the given caption if caption is set', () => {
    const table = findTable("A", false, "BBB");
    expect(table.prop('caption')).toEqual("BBB");
  });


  it('should specify "0" as the book property', () => {
    const table = findTable("Book Test")
    expect(table.prop('book')).toEqual('0');
  });

  it('should contain an author column', () => {
    const columns = findTable("Author Test").prop('columns');
    const column = findColumn(columns, "book.author");
    expect(column).toHaveProperty("classes", 'author');
  });

  it('should contain a description column', () => {
    const columns = findTable("Description Test").prop('columns');
    const column = findColumn(columns, "book");
    expect(column).toHaveProperty("formatter");
    expect(column).toHaveProperty("classes", 'description');
  });

  it('should contain a need column', () => {
    const columns = findTable("Need Test").prop('columns');
    const column = findColumn(columns, "1");
    expect(column).toHaveProperty("classes", 'need');
  });

  it('should have no formatter in the need columns by default', () => {
    const columns = findTable("Need Renderer Test").prop('columns');
    const column = findColumn(columns, "1");
    expect(column).not.toHaveProperty('formatter');
  });

  it('should have a formatter in the need column if editable is set to true', () => {
    const columns = findTable("Need Renderer Test", true).prop('columns');
    const column = findColumn(columns, "1");
    console.log(column);
    expect(column).toHaveProperty('formatter');
  });
});

