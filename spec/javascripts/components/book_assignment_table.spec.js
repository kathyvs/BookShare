import React from 'react';
import ReactDOMServer from 'react-dom/server';
import { shallow, mount, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import BookAssignmentTable from 'components/book_assignment_table';
import { findColumn, findFormatter } from './book_share_helper.js';

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

  it('should contain an author column', () => {
    const columns = findTable("Author Test").prop('columns');
    const column = findColumn(columns, "book.author");
    expect(column).toHaveProperty("classes", 'author');
  });

  it('should contain a title column', () => {
    const columns = findTable("Title Test").prop('columns');
    const column = findColumn(columns, "book");
    expect(column).toHaveProperty("formatter");
    expect(column).toHaveProperty("classes", 'description');
  });

  it('should contain a needs column', () => {
    const columns = findTable("Description Test").prop('columns');
    const column = findColumn(columns, "needs");
    expect(column).toHaveProperty("classes", 'need');
  });

  it('should contain a profile_assignments column', () => {
    const columns = findTable("Brining Test").prop('columns');
    const column = findColumn(columns, "profile_assignments");
    expect(column).toHaveProperty("formatter");
    expect(column).toHaveProperty("classes", 'bringing');
  });

});

describe('BookAssignmentTable.generalAssignmentFormatter', () => {

  const profiles = [{
    profile: { name: "First Profile", _id: {'$oid' : 'aa'}},
    count: 1,
  }, {
    profile: { name: "Second Profile", _id: {'$oid' : 'bb'}},
    count: 3,
  }];

  const fetchFormatter = function() {
    const wrapper = shallow(<BookAssignmentTable assignments={[]} caption={"General Formatter Test"}/>);
    return findFormatter(wrapper, 'profile_assignments');
  }

  it('is an element with a profile, count and index', () => {
    const formatter = fetchFormatter();
    const result = formatter(profiles);
    const counts = shallow(result).find("NameAndCount");
    for (var i = 0; i < counts.length; i++) {
      const nameAndCount = counts.at(i);
      expect(nameAndCount.prop('profile')).toEqual(profiles[i].profile);
      expect(nameAndCount.prop('count')).toEqual(profiles[i].count);
    }
  });

});
