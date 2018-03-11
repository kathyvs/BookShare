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

  const findTable = function (caption) {
    const wrapper = shallow(<BookCountTable counts={counts} caption={caption}/>);
    return wrapper.find("BookShareTable").first();
  };

  it('should copy counts to the table data', () => {
    const table = findTable("Data Test")
    expect(table.prop('data')).to.equal(counts);
  });

  it('should specify "0" as the book property', () => {
    const table = findTable("Book Test")
    console.log(table.debug());
    expect(table.prop('book')).to.equal('0');
  });
});

