class UserShow extends React.Component {
  getInitialState() {
    const {
      profilePicture,
      user,
    } = this.props;

    return {
      profilePicture,
      user
    };
  }

  render () {
    //debugger;
    return(
      <div >
        <div>
					<div>
            <div
            style={{
              zIndex: -1,
              backgroundImage: "url("+this.props.profilePicture+")",
              backgroundRepeat: "no-repeat",
              backgroundSize: "cover",
              height: 315,
              "width": "100%",
              "min-width": "1000px",
            }}
            />
            <div className="user-show__cover-photo-camera">
              <i className="fa fa-camera fa-g"/>
            </div>
            <div>
              <h3 className="user-show__username-title">
                {this.props.user.first_name} {this.props.user.last_name}
              </h3>
            </div>
					</div>
          <div>
            <div className="user-show__timeline-actions">
              <a className="btn btn-default">Update Information</a>
            </div>
            <div className="user-show__timeline">
              <a>Biography</a>
              <a>Information</a>
              <a>Friends</a>
              <a>Photos</a>
              <a>More <i className="caret"/></a>
            </div>
            <span>
              <div
                className="user-show__profile-picture"
                style={{
                  backgroundImage: "url("+this.props.profilePicture+")",
                  width: 200,
                  height: 200,
                }}
              />
            </span>
          </div>
        </div>
        <pre>{JSON.stringify(this.state, null, 2)}</pre>
        <div style={{"min-height": "5000px"}}/>

      </div>
    );
  }
}

