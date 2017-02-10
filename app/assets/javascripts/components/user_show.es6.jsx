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
              backgroundImage: "url(https://secure.gravatar.com/avatar/6d55e8945208bb95200db55e13655470?s=200)",
              backgroundRepeat: "no-repeat",
              backgroundSize: "cover",
              height: 315,
              "width": "100%",
            }}
            />
            <div>
              <h3 className="user-show__username-title">
                {this.props.user.first_name} {this.props.user.last_name}
              </h3>
            </div>
					</div>
          <div>
            <div className="user-show__timeline">
              <a>Biography</a>
              <a>Information</a>
              <a>Friends</a>
              <a>Photos</a>
              <a>More</a>
            </div>
            <span>
              <div
                className="user-show__profile-picture"
                style={{
                  backgroundImage: "url(https://secure.gravatar.com/avatar/6d55e8945208bb95200db55e13655470?s=200)",
                  width: 200,
                  height: 200,
                }}
              />
            </span>
          </div>
        </div>
        <pre>{JSON.stringify(this.state, null, 2)}</pre>
      </div>
    );
  }
}

