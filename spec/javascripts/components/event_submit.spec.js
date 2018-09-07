import React from 'react';
import { shallow, mount, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import EventSubmit from 'components/event_submit';

configure({ adapter: new Adapter() });

describe('EventSubmit', () => {

  it('should contain a submit input', () => {
    const wrapper = shallow(<EventSubmit tableName='test'/>);
    const submit = wrapper.find('input');
    console.log("Submit length = " + submit.length);
    expect(submit).toHaveLength(1);

  });

});

