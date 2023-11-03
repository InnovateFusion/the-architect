import Link from "next/link";
import useTranslation from "next-translate/useTranslation";

export const metadata = {
  title: "Reset Password - The Architect",
  description: "Page description",
};

export default function ResetPassword() {
  const { t } = useTranslation("common");

  return (
    <section className="">
      <div className="max-w-6xl mx-auto px-4 sm:px-6">
        <div className="pt-12 pb-12 md:pt-10 md:pb-10">
          {/* Page header */}
          <div className="max-w-3xl mx-auto text-center pb-12 md:pb-20">
            <h1 className="h1 mb-4 md:mx-24">{t("r_header")}</h1>
            <p className="text-xl ">{t("r_header_desc")}</p>
          </div>

          {/* Form */}
          <div className="max-w-sm mx-auto">
            <form action="/home">
              <div className="flex flex-wrap -mx-3 mb-4">
                <div className="w-full px-3">
                  <label
                    className="block text-sm font-medium mb-1"
                    htmlFor="email"
                  >
                    {t("r_email")} <span className="text-red-600">*</span>
                  </label>
                  <input
                    id="email"
                    type="email"
                    className="form-input w-full text-gray-800"
                    placeholder="Enter your email address"
                    required
                  />
                </div>
              </div>
              <div className="flex flex-wrap -mx-3 mt-6">
                <div className="w-full px-3">
                  <button className="btn text-white bg-blue-600 hover:bg-blue-700 w-full">
                    {t("r_action_1")}
                  </button>
                </div>
              </div>
            </form>
            <div className=" text-center mt-6">
              {t("r_ques")}
              <Link
                href="/auth/signup"
                className="text-blue-600 hover:underline transition duration-150 ease-in-out"
              >
                {t("r_action_2")}
              </Link>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
