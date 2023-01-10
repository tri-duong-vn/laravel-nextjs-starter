import Link from "next/link";
import { H1 } from "./../components/Typography/Headers";

export default function Home() {
    return (
        <>
            <div className="flex w-screen h-screen items-center justify-center">
                <div className="w-1/2">
                    <H1 center={true} withMargin={true}>
                        Welcome to the Starter Kit
                    </H1>
                    <div className="flex justify-center items-center text-blue-500 underline">
                        <Link href="/user/login">Login</Link>
                    </div>
                </div>
            </div>
        </>
    );
}
