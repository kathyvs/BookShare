import React from 'react';
import { expect } from 'chai';
import { shallow, mount, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import BookShareTable from 'components/book_share_table';

configure({ adapter: new Adapter() });

describe('BookShareTable', () => {
  const data = [
    {name: 'Name 1', value: 3},
    {name: 'Name 2', value: 4}
    ];

  it('should render a bootstrap table', () => {
    const wrapper = shallow(<BookShareTable data={data} caption="Table Test"/>);
    console.log(wrapper.debug());
    expect(wrapper.find("BootstrapTableContainer")).to.have.length(1);
  });

  it('should copy data to the table data', () => {
    const wrapper = shallow(<BookShareTable data={data} caption="Data Test"/>);
    const table = wrapper.find("BootstrapTableContainer").first();
    console.log(table.debug());

    expect(table.prop('data')).to.equal(data);
  });
});
