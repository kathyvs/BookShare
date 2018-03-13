import React from 'react';
import { shallow, mount, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import BookAssignmentTable from 'components/book_assignment_table';
import { findColumn } from './book_share_helper.js';

configure({ adapter: new Adapter() });

describe('BookAssignmentTable', () => {
  const assignments = [
    {'book': {'title': 'Test 1', 'key': '1'}},
    {'book': {'title': 'Test 2', 'key': '2'}}];

  const findTable = function (caption) {
    const wrapper = shallow(<BookAssignmentTable assignments={assignments} caption={caption}/>);
    return wrapper.find("BookShareTable").first();
  };

  it('should copy the caption', () => {
    const table = findTable("Caption Test");
    expect(table.prop("caption")).toBe("Caption Test");
  });

  it('should use "book" as the book property', () => {
    const table = findTable("Caption Test");
    expect(table.prop("book")).toBe("book");
  });

  it('should contain a description column', () => {
    const columns = findTable("Description Test").prop('columns');
    console.log(columns);
    const column = findColumn(columns, "description");
    expect(column).toHaveProperty("extractBy");
    expect(column).toHaveProperty("classes", ['description']);
  });

  it('should contain a needs column', () => {
    const columns = findTable("Description Test").prop('columns');
    console.log(columns);
    const column = findColumn(columns, "needs");
    expect(column).toHaveProperty("classes", ['need']);
  });

});
