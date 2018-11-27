import React from "react"
import PropTypes from "prop-types"

function BookAssignmentRow  ( {assignment} ) {
  return (
    <tr>
      <td>{assignment.book.author}</td>
      <BookDescription book={assignment.book}/>
      <td className="need">{assignment.need}</td>
      <td className="bringing">
        {assignment.profile_assignments.map((pair, index) => (
          <NameAndCount key={id_of(pair.profile)} profile={pair.profile} count={pair.count} index={index}/>))}</td>
    </tr>
  );
}

BookAssignmentRow.propTypes = {
  assignment: PropTypes.shape({
    book: PropTypes.object,
    profile_assignments: PropTypes.array
  })
};

function BookDescription ( {book} ) {
  const title = <span className="title">{book.title}</span>;
  const shortName = book.short_name && <span className="short-name">[{book.short_name}]</span>;
  return (<th scope="row">{title} {shortName}</th>);
}

BookDescription.propTypes = {
  book: PropTypes.shape({
    title: PropTypes.string.isRequired,
    author: PropTypes.string
  })
};

function NameAndCount ( {profile, count, index} ) {
  const prefix = index > 0 && ", ";
  const countString = count > 1 ? ` (${count})` : "";
  return (<span>{prefix}{profile.name}{countString}</span>);
}

NameAndCount.propTypes = {
  profile: PropTypes.shape({
    _id: PropTypes.object,
    name: PropTypes.string.isRequired,
  }),
  count: PropTypes.number,
  index: PropTypes.number.isRequired
}

function id_of(obj) {
  return obj._id['$oid']
}

export default BookAssignmentRow

