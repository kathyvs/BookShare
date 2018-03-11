import React from 'react';
import { shallow, mount, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import BookAssignmentTable from 'components/book_assignment_table';

configure({ adapter: new Adapter() });

describe('BookAssignmentTable', () => {
  const assignments = [
    {'book': {'title': 'Test 1', 'key': '1'}}];

  const findTable = function (caption) {
    const wrapper = shallow(<BookAssignmentTable assignments={assignments} caption={caption}/>);
    return wrapper.find("BookShareTable").first();
  };

  it('should copy the caption', () => {
    const table = findTable("Caption Test");
    console.log(table.debug());
    expect(table.prop("caption")).toBe("Caption Test");
  });

  it('should use "book" as the book property', () => {
    const table = findTable("Caption Test");
    console.log(table.debug());
    expect(table.prop("book")).toBe("book");
  });
});
