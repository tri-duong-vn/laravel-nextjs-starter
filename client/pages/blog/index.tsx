import Link from "next/link";
import { PrimaryButton } from "./../../components/Button/Button";
import { logout } from "./../../store/auth/authActions";
import { connect } from "react-redux";
import {useEffect, ReactElement} from "react";
import {NextRouter, useRouter} from "next/router";

function Blog(props: any): ReactElement {
    const router: NextRouter = useRouter();

    useEffect(() => {
        if (!props.isAuthenticated) {
            router.push("/user/login");
        }
    }, [props.isAuthenticated]);

    // Return statement.
    return (
        <>
            <div>Blog</div>
        </>
    )
}

const mapStateToProps = (state: any) => ({
    isAuthenticated: state.auth.isAuthenticated,
    loading: state.auth.registerLoading,
});

export default connect(mapStateToProps, { logout })(Blog);
