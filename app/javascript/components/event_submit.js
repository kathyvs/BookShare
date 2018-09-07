import React from "react"
import PropTypes from "prop-types"

class EventSubmit extends React.Component {
  render () {
    return (
      <input type="submit" name="commit" value="Create Event"/>
    );
  }
}

EventSubmit.propTypes = {
  tableName: PropTypes.string,
  nameField: PropTypes.string
};
export default EventSubmit
