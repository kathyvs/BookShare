import React from "react"
import PropTypes from "prop-types"

class EventSubmit extends React.Component {
  render () {
    const title = this.props.type === "new" ? "Create Event" : "Save Event";
    return (
      <input type="submit" name="commit" value={title}/>
    );
  }
}

EventSubmit.propTypes = {
    tableName: PropTypes.string,
    nameField: PropTypes.string,
    type: PropTypes.string
};

export default EventSubmit
