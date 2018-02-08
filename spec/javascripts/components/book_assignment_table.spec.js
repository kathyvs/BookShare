import React from 'react';
import { expect } from 'chai';
import { shallow, mount, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import BookAssignmentTable from 'components/book_assignment_table';

configure({ adapter: new Adapter() });

describe('BookAssignmentTable', () => {
  const assignments = [
    {'book': {'title': 'Test 1', 'key': '1'}}];

  it('should render a table', () => {
    const wrapper = shallow(<BookAssignmentTable assignments={assignments} caption="Test"/>);
    console.log(wrapper.debug());
    expect(wrapper.find("table")).to.have.length(1);
  });
});
