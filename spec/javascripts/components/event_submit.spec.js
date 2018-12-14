import React from 'react';
import { shallow, mount, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import EventSubmit from 'components/event_submit';

configure({ adapter: new Adapter() });

describe('EventSubmit', () => {

  it('should contain a submit input', () => {
    const wrapper = shallow(<EventSubmit tableName='test' type='new'/>);
    const submit = wrapper.find('input');
    expect(submit).toHaveLength(1);

  });

  it('says create event when type is new', () => {
     const wrapper = shallow(<EventSubmit tableName='test' type='new'/>);
     const submit = wrapper.find('input');
     expect(submit.prop('value')).toEqual('Create Event');
  });

  it('says save event when type is edit', () => {
      const wrapper = shallow(<EventSubmit tableName='test' type='edit'/>);
      const submit = wrapper.find('input');
      expect(submit.prop('value')).toEqual("Save Event");
  });
});

