import React from 'react';
import { expect } from 'chai';
import { shallow, mount, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import BookCountTable from 'components/book_count_table';

configure({ adapter: new Adapter() });

describe('BookCountTable', () => {
  const counts = [
    [{'book': {'title': 'Test 1', 'key': '1'}}, 3]
    ];

  it('should render a book share table', () => {
    const wrapper = shallow(<BookCountTable counts={counts} caption="Table Test"/>);
    expect(wrapper.find("BookShareTable")).to.have.length(1);
  });

  it('should copy counts to the table data', () => {
    const wrapper = shallow(<BookCountTable counts={counts} caption="Data Test"/>);
    const table = wrapper.find("BookShareTable").first();
    console.log(table.debug());
    expect(table.prop('data')).to.equal(counts);
  });
});

